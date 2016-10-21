// implement fork from user space

#include <inc/string.h>
#include <inc/lib.h>

// PTE_COW marks copy-on-write page table entries.
// It is one of the bits explicitly allocated to user processes (PTE_AVAIL).
#define PTE_COW		0x800

//
// Custom page fault handler - if faulting page is copy-on-write,
// map in our own private writable copy.
//
static void
pgfault(struct UTrapframe *utf)
{
	void *addr = (void *) utf->utf_fault_va;
	uint32_t err = utf->utf_err;
	int r;

	// Check that the faulting access was (1) a write, and (2) to a
	// copy-on-write page.  If not, panic.
	// Hint:
	//   Use the read-only page table mappings at uvpt
	//   (see <inc/memlayout.h>).

	// LAB 4: Your code here.

	// pte_t *pt = (pde_t*)UVPT + PDX(addr);
	// pte_t *pt_entry = (pte_t*)PTE_ADDR(pt) + PTX(addr);

	volatile pte_t *pt_entry = uvpt + PGNUM(addr);
	if(!(err & FEC_WR && PTE_COW & *pt_entry)){
		panic("Fatal error at pgfault");
	}

	// Allocate a new page, map it at a temporary location (PFTEMP),
	// copy the data from the old page to the new page, then move the new
	// page to the old page's address.
	// Hint:
	//   You should make three system calls.

	// LAB 4: Your code here.
	envid_t e = sys_getenvid();
	addr = ROUNDDOWN(addr, PGSIZE);
	if(sys_page_alloc(e ,(void*)PFTEMP, PTE_P | PTE_W | PTE_U))
		panic("Fatal - failed page alloc at pgfault");

	memmove((void*)PFTEMP, addr, PGSIZE);
	if((r = sys_page_map(e, PFTEMP, e, addr, PTE_P | PTE_U | PTE_W)))
		panic("Fatal %d", r);
	// panic("pgfault not implemented");
}

//
// Map our virtual page pn (address pn*PGSIZE) into the target envid
// at the same virtual address.  If the page is writable or copy-on-write,
// the new mapping must be created copy-on-write, and then our mapping must be
// marked copy-on-write as well.  (Exercise: Why do we need to mark ours
// copy-on-write again if it was already copy-on-write at the beginning of
// this function?)
//
// Returns: 0 on success, < 0 on error.
// It is also OK to panic on error.
//
static int
duppage(envid_t envid, unsigned pn)
{
	int r;

	// LAB 4: Your code here.
	envid_t e = sys_getenvid(); 
	void *addr = (void*)(pn*PGSIZE);

	// pte_t *pt = (pde_t*)UVPT + PDX(addr);
	// pte_t *pt_entry = (pte_t*)PTE_ADDR(pt) + PTX(addr);	
	volatile pte_t *pt_entry = uvpt + pn;

	if(!(*pt_entry & PTE_P))
		return -1;

	int res;
	if(*pt_entry & PTE_W || *pt_entry & PTE_COW){
		res = sys_page_map(e, addr, envid, addr, PTE_P | PTE_U | PTE_COW);
		res = sys_page_map(e, addr, e    , addr, PTE_P | PTE_U | PTE_COW);
	}
	else{
		res = sys_page_map(e, addr, envid, addr, PTE_P | PTE_U);
	}

	if(res)
		panic("Fatal - unable to map page at duppage");

	// panic("duppage not implemented");
	return 0;
}

//
// User-level fork with copy-on-write.
// Set up our page fault handler appropriately.
// Create a child.
// Copy our address space and page fault handler setup to the child.
// Then mark the child as runnable and return.
//
// Returns: child's envid to the parent, 0 to the child, < 0 on error.
// It is also OK to panic on error.
//
// Hint:
//   Use uvpd, uvpt, and duppage.
//   Remember to fix "thisenv" in the child process.
//   Neither user exception stack should ever be marked copy-on-write,
//   so you must allocate a new page for the child's user exception stack.
//
envid_t
fork(void)
{
	// LAB 4: Your code here.
	set_pgfault_handler(&pgfault);
	
	envid_t e = sys_exofork();
	if(e < 0)
		panic("Fatal - unable to get new env");

	if(e == 0){
		thisenv = &envs[ENVX(sys_getenvid())];
		return 0;
	}
	else{
		// copy mapping
		for(int i = 0; i < PGNUM(UTOP); i++){
			// Get page table entry			
			if(i == PGNUM(UXSTACKTOP) || i == (PGNUM(UXSTACKTOP) - 1))	continue;
			
			volatile pde_t *pd = uvpd + i/NPTENTRIES;
			if(!(*pd & PTE_P))	continue;
			
			volatile pte_t *pt = uvpt + i;
			if(*pt & PTE_P && *pt & PTE_U){
				duppage(e, i);
			}
		}

		if(sys_env_set_pgfault_upcall(e, thisenv->env_pgfault_upcall))
			panic("Fatal");

		if(sys_page_alloc(e,(void*)(UXSTACKTOP-PGSIZE), PTE_W | PTE_U | PTE_P))
			panic("Fatal");

		if(sys_env_set_status(e, ENV_RUNNABLE))
			panic("Fatal");

		return e;			
	}
	// panic("fork not implemented");
}

// Challenge!
int
sfork(void)
{
	panic("sfork not implemented");
	return -E_INVAL;
}
