#include <stdio.h>
#include <stdlib.h>

typedef struct Link {
    int  elem;
    struct Link *next;
}link;

int main()
{
    int n;
    scanf("%d", &n);
    link* head = (link*) malloc(sizeof(link));
    head->elem = 0;
    head->next = NULL;
    link* temp = NULL;
    for (int i = 0; i < n; i++)
    {
        link* newLink = (link*) malloc(sizeof(link));
        scanf("%d ", &newLink->elem);
        newLink->next = head->next;
        head->next = newLink;
    }
    for (int i = 0; i < n + 1; i++)
    {
        printf("%d ", head->elem);
        temp = head;
        head = head->next;
        free(temp);
    }
    return 0;
}