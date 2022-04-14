#include <defs.h>
#include <riscv.h>
#include <stdio.h>
#include <string.h>
#include <swap.h>
#include <swap_lru.h>
#include <list.h>
#include <pmm.h>

list_entry_t pra_list_head, *curr_ptr;

static int
_lru_init_mm(struct mm_struct *mm)
{
    // init page list, set sm_priv
    list_init(&pra_list_head);
    mm->sm_priv = &pra_list_head;
    return 0;
}

static int
_lru_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
    // insert the incoming page to the next position of head pointer
    list_entry_t *head = (list_entry_t *)mm->sm_priv;
    list_entry_t *entry = &(page->pra_page_link);
    assert(entry != NULL && head != NULL);
    list_add(head, entry);
    return 0;
}

static int
_lru_swap_out_victim(struct mm_struct *mm, struct Page **ptr_page, int in_tick)
{
    list_entry_t *head = (list_entry_t*) mm->sm_priv;
    assert(head != NULL && in_tick == 0);
    // if the page list is empty, just do nothing and return
    if (list_prev(head) == head)
    {
        *ptr_page = NULL;
        return 0;
    }
    curr_ptr = list_prev(head);
    list_entry_t *target = NULL;
    int times = __INT_MAX__;
    do
    {
        *ptr_page = le2page(curr_ptr, pra_page_link);
        // get the constant in page
        int temp = *(unsigned char *)(*ptr_page)->pra_vaddr;
        // if the used times is smaller than the current one,
        // it will be the new target to swap out
        if (temp < times)
        {
            times = temp;
            target = curr_ptr;
        }
        // move the current pointer to the previous one
        curr_ptr = list_prev(curr_ptr);
    } while (curr_ptr != head);
    // get the target, delete it from the list and return
    *ptr_page = le2page(target, pra_page_link);
    list_del(target);
    return 0;
}

static int
_lru_check_swap(void)
{

    int i = 0x10;

    cprintf("---------LRU check begin----------\n");
    cprintf("write Virt Page 3 in lru_check_swap\n");
    *(unsigned char *)0x3000 = i;
    i += 1;
    assert(pgfault_num == 4);
    cprintf("write Virt Page 1 in lru_check_swap\n");
    *(unsigned char *)0x1000 = i;
    i += 1;
    assert(pgfault_num == 4);
    cprintf("write Virt Page 4 in lru_check_swap\n");
    *(unsigned char *)0x4000 = i;
    i += 1;
    assert(pgfault_num == 4);
    cprintf("write Virt Page 2 in lru_check_swap\n");
    *(unsigned char *)0x2000 = i;
    i += 1;
    assert(pgfault_num == 4);
    cprintf("write Virt Page 5 in lru_check_swap\n");
    *(unsigned char *)0x5000 = i;
    i += 1;
    assert(pgfault_num == 5);
    cprintf("write Virt Page 3 in lru_check_swap\n");
    *(unsigned char *)0x3000 = i;
    i += 1;
    assert(pgfault_num == 6);
    cprintf("write Virt Page 1 in lru_check_swap\n");
    *(unsigned char *)0x1000 = i;
    i += 1;
    assert(pgfault_num == 7);
    cprintf("write Virt Page 4 in lru_check_swap\n");
    *(unsigned char *)0x4000 = i;
    i += 1;
    assert(pgfault_num == 8);
    cprintf("write Virt Page 4 in lru_check_swap\n");
    *(unsigned char *)0x4000 = i;
    i += 1;
    assert(pgfault_num == 8);
    cprintf("write Virt Page 5 in lru_check_swap\n");
    *(unsigned char *)0x5000 = i;
    i += 1;
    assert(pgfault_num == 8);
    cprintf("write Virt Page 2 in lru_check_swap\n");
    *(unsigned char *)0x2000 = i;
    i += 1;
    assert(pgfault_num == 9);
    cprintf("write Virt Page 3 in lru_check_swap\n");
    *(unsigned char *)0x3000 = i;
    i += 1;
    assert(pgfault_num == 10);
    cprintf("LRU check succeed!\n");

    return 0;
}

static int
_lru_init(void)
{
    return 0;
}

static int
_lru_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}

static int
_lru_tick_event(struct mm_struct *mm)
{
    return 0;
}

struct swap_manager swap_manager_lru =
    {
        .name = "lru swap manager",
        .init = &_lru_init,
        .init_mm = &_lru_init_mm,
        .tick_event = &_lru_tick_event,
        .map_swappable = &_lru_map_swappable,
        .set_unswappable = &_lru_set_unswappable,
        .swap_out_victim = &_lru_swap_out_victim,
        .check_swap = &_lru_check_swap,
};
