1)
#include<iostream>
#include<stack>
#include<string>
#include<unordered_map>

using namespace std;

bool isOperator(char c) {
return c == '+' || c == '-' || c == '*' || c == '/';
}

int precedence(char op) {
if(op == '+' || op == '-') return 1;
if (op == '*' || op == '/') return 2;
return 0;
}

string infixToPostfix(const string& infix) {
stack<char> opStack;
string postfix;

for(char c : infix) {
if (isalnum(c)) {
postfix += c;
} else if (c == '(') {
opStack.push(c);
} else if (c == ')') {
while (!opStack.empty() && opStack.top() != '(') {
postfix += opStack.top();
opStack.pop();
}
opStack.pop();
} else {
while (!opStack.empty() && precedence(opStack.top()) >= precedence(c)) {
postfix += opStack.top();
opStack.pop();
}
opStack.push(c);
}
}

while (!opStack.empty()) {
postfix += opStack.top();
opStack.pop();
}
return postfix;
}

int main() {
string infixExpression;
cout << "Enter infix expression: ";
getline(cin, infixExpression);

string postfixExpression = infixToPostfix(infixExpression);
cout << "Postfix expression: " << postfixExpression << endl;

return 0;
}

2)
#include <bits/stdc++.h>
using namespace std;

bool isOperand(char c) {
return isdigit(c);
}

double evaluatePrefix(string exprsn) {
stack<double> Stack;
for (int j = exprsn.size() - 1; j >= 0; j--) {
if (isOperand(exprsn[j]))
Stack.push(exprsn[j] - '0');
else {
double o1 = Stack.top();
Stack.pop();
double o2 = Stack.top();
Stack.pop();
switch (exprsn[j]) {
case '+':
Stack.push(o1 + o2);
break;
case '-':
Stack.push(o1 - o2);
break;
case '*':
Stack.push(o1 * o2);
break;
case '/':
Stack.push(o1 / o2);
break;
}
}
}
return Stack.top();
}

int main() {
string exprsn;
cout << "Enter a prefix expression: ";
cin >> exprsn;
cout << "Result: " << evaluatePrefix(exprsn) << endl;
return 0;
}

3)

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define SIZE 5

struct Queue {
int front, rear;
char data[SIZE][100];
};

typedef struct Queue Queue;

void sender(Queue *q, char item[100]) {
if (q->front == (q->rear + 1) % SIZE)
printf("Queue Full\n");
else {
q->rear = (q->rear + 1) % SIZE;
strcpy(q->data[q->rear], item);
if (q->front == -1)
q->front++;
}
}

void receiver(Queue *q) {
    if (q->front == -1) {
        printf("Queue is empty\n");
    } else {
        printf("Message Received: %s\n", q->data[q->front]);
        if (q->front == q->rear) {
            q->front = -1;
            q->rear = -1;
        } else {
            q->front = (q->front + 1) % SIZE;
        }
    }
}


void display(Queue q) {
printf("\n");
int i;
if (q.front == -1)
printf("Queue is Empty\n");
else {
printf("Queue Content:\n");
for (i = q.front; i != q.rear; i = (i + 1) % SIZE)
printf("%s\n", q.data[i]);
printf("%s\n", q.data[i]);
}
printf("\n");
}

int main() {
int ch;
char message[100];
Queue q;
q.front = -1, q.rear = -1;
while (1) {
printf("Choose an option:\n");
printf("\t1) Sender\n");
printf("\t2) Receiver\n");
printf("\t3) Display\n");
printf("\t4) Exit\n");
printf("Enter your choice: ");
scanf("%d", &ch);
switch (ch) {
case 1:
printf("Enter message to be Sent: ");
scanf(" %[^\n]", message);
sender(&q, message);
break;
case 2:
receiver(&q);
break;
case 3:
display(q);
break;
case 4:
exit(0);
default:
printf("Enter Valid Option\n");
exit(0);
}
}
return 0;
}


4)
#include <stdio.h>
#include <stdlib.h>

struct node {
int co, po;
struct node *next;
};

typedef struct node* NODE;

NODE insertEnd(NODE start, int co, int po) {
NODE temp = (NODE)malloc(sizeof(struct node));
temp->co = co;
temp->po = po;
temp->next = NULL;
if (!start) return temp;
NODE cur = start;
while (cur->next) cur = cur->next;
cur->next = temp;
return start;
}

void display(NODE start) {
while (start) {
printf("%dx^%d", start->co, start->po);
if (start->next) printf(" + ");
start = start->next;
}
printf("\n");
}

NODE addTerm(NODE res, int co, int po) {
NODE temp = res;
while (temp) {
if (temp->po == po) {
temp->co += co;
return res;
}
temp = temp->next;
}
return insertEnd(res, co, po);
}

NODE multiply(NODE poly1, NODE poly2) {
NODE res = NULL;
for (NODE p1 = poly1; p1; p1 = p1->next)
for (NODE p2 = poly2; p2; p2 = p2->next)
res = addTerm(res, p1->co * p2->co, p1->po + p2->po);
return res;
}

int main() {
NODE poly1 = NULL, poly2 = NULL, result = NULL;
int n, m, co, po;
    
scanf("%d", &n);
for (int i = 0; i < n; i++) {
scanf("%d%d", &co, &po);
poly1 = insertEnd(poly1, co, po);
}
display(poly1);
    
scanf("%d", &m);
for (int i = 0; i < m; i++) {
scanf("%d%d", &co, &po);
poly2 = insertEnd(poly2, co, po);
}
display(poly2);
    
result = multiply(poly1, poly2);
display(result);
    
return 0;
}



5)
#include <stdio.h>
#include <stdlib.h>
#define SIZE 5
int count;
struct node
{
int data;
struct node *addr;
};
typedef struct node *NODE;
NODE insertend(NODE last,int item)
{
NODE temp;
if(count>=SIZE)
{
printf("\n Queue full");
return last;
}
count=count+1;
temp=(NODE)malloc(sizeof(struct node));
temp->data=item;
if(last==NULL)
{
temp->addr=temp;
return temp;
}
else
{
temp->addr=last->addr;
last->addr=temp;
return temp;
}
}
NODE deletebegin(NODE last)
{
NODE temp;
if(last==NULL)
{
printf("\n Queue empty");
return NULL;
}
if(last->addr==last)
{
printf("\n Element deleted is %d\n",last->data);
free(last);
return NULL;
}
else
{
temp=last->addr;
last->addr=temp->addr;

printf("\n Element deleted is %d\n",temp->data);
free(temp);
return last;
}
}
void display(NODE last)
{
NODE temp;
if(last==NULL)
printf("\n Queue is empty");
else
{
printf("\n Queue Content are\n");
temp=last->addr;
while(temp!=last)
{
printf("%d\t",temp->data);
temp=temp->addr;
}
printf("%d\t",temp->data);
}
}
int main()
{
NODE last=NULL;
int item,ch;
for(;;)
{
printf("\n1.Insert\n2.Delete\n3.Display\n4.Exit");
printf("\nRead Choice :");
scanf("%d",&ch);
switch(ch)
{
case 1:printf("\n Read data to be inserted:");
scanf("%d",&item);

last=insertend(last,item);
break;

case 2:last=deletebegin(last);
break;
case 3:display(last);
break;
default:exit(0);
}
}
return 0;
}



6)
#include <stdio.h>

#define TABLE_SIZE 10
#define PRIME 7

int hashTable[TABLE_SIZE];

void initializeHashTable() {
for (int i = 0; i < TABLE_SIZE; i++)
hashTable[i] = -1;
}

int hash1(int key) {
return key % TABLE_SIZE; 
}

int hash2(int key) {
return PRIME - (key % PRIME); 
}

void insert(int key) {
int index = hash1(key);
int index2 = hash2(key);
int i = 0;

while (hashTable[(index + i * index2) % TABLE_SIZE] != -1) {
if (hashTable[(index + i * index2) % TABLE_SIZE] == key)
return;
i++;
}

hashTable[(index + i * index2) % TABLE_SIZE] = key;
}

void displayHashTable() {
for (int i = 0; i < TABLE_SIZE; i++)
printf("Slot %d: %s\n", i, hashTable[i] != -1 ? "occupied" : "empty");
}

int main() {
initializeHashTable();

insert(10);
insert(20);
insert(15);
insert(7);

displayHashTable();

return 0;
}

7)
#include <stdio.h>
#include <stdlib.h>

void heapify(int a[], int n, int i) {
int largest = i, left = 2 * i, right = 2 * i + 1;

if (left <= n && a[left] > a[largest])
largest = left;
if (right <= n && a[right] > a[largest])
largest = right;

if (largest != i) {
int temp = a[i];
a[i] = a[largest];
a[largest] = temp;
heapify(a, n, largest);
}
}

void buildHeap(int a[], int n) {
for (int i = n / 2; i >= 1; i--)
heapify(a, n, i);
}

int main() {
int n, a[10], ch;

while (1) {
printf("\n1. Create Heap\n2. Extract Max\n3. Exit\nChoice: ");
scanf("%d", &ch);
if (ch == 1) {
printf("Enter number of elements: ");
scanf("%d", &n);
printf("Enter elements:\n");
for (int i = 1; i <= n; i++)
scanf("%d", &a[i]);

buildHeap(a, n);
printf("Heap:\n");
for (int i = 1; i <= n; i++)
printf("%d\t", a[i]);

} else if (ch == 2 && n > 0) {
printf("Max element: %d\n", a[1]);
a[1] = a[n--];
heapify(a, n, 1);

if (n > 0) {
printf("Reconstructed heap:\n");
for (int i = 1; i <= n; i++)
printf("%d\t", a[i]);
} else {
printf("Heap is empty\n");
}

} else if (ch == 3) {
break;
} else {
printf("Invalid choice or empty heap\n");
}
}
return 0;
}


8)
#include <stdio.h>
#include <stdlib.h>
#include<ctype.h>
struct node
{
 char data;
 struct node *left;
 struct node *right;
};
typedef struct node *NODE;
struct stack
{
 int top;
 NODE data[10];
};
typedef struct stack STACK;
void push(STACK *s,NODE item)
{
 s->data[++(s->top)]=item;
}
NODE pop(STACK *s)
{
 return s->data[(s->top)--];
}
int preced(char symbol)
{
 switch(symbol)
 {
 case '$':return 5;
 case '*':
 case '/':return 3;
 case '+':
 case '-':return 1;
 }
}
NODE createnode(char item)
{
 NODE temp;
 temp=(NODE)malloc(sizeof(struct node));
 temp->data=item;
 temp->left=NULL;
 temp->right=NULL;
 return temp;
}
void preorder(NODE root)
{
 if(root!=NULL)
 {
 printf("%c",root->data);
 preorder(root->left);
 preorder(root->right);
 }
}
void inorder(NODE root)
{
 if(root!=NULL)
 {
 inorder(root->left);
 printf("%c",root->data);
 inorder(root->right);
 }
}
void postorder(NODE root)
{
 if(root!=NULL)
 {
 postorder(root->left);
 postorder(root->right);
 printf("%c",root->data);
 }
}
NODE create_expr_tree(NODE root,char infix[10])
{
 STACK TS,OS;
 TS.top=-1;
 OS.top=-1;
 int i;
 char symbol;
 NODE temp,t;
 for(i=0;infix[i]!='\0';i++)
 {
 symbol=infix[i];
 temp=createnode(symbol);
 if(isalnum(symbol))
 push(&TS,temp);
 else
 {
 if(OS.top==-1)
 push(&OS,temp);
 else
 {
 while(OS.top!=-1 && preced(OS.data[OS.top]->data)>=
preced(symbol))
 {
 t=pop(&OS);
t->right=pop(&TS);
t->left=pop(&TS);
push(&TS,t);
 }
 push(&OS,temp);
 }
 }
 }
 while(OS.top!=-1)
 {
 t=pop(&OS);
 t->right=pop(&TS);
 t->left=pop(&TS);
 push(&TS,t);
 }
 return pop(&TS);
}
int main()
{
 char infix[10];
 NODE root=NULL;
 printf("\n Read the infix expression :");
 scanf("%s",infix);
 root=create_expr_tree(root,infix);
 printf("\n The preorder traversal is\n");
 preorder(root);
 printf("\n The inorder traversal is\n");
 inorder(root);
 printf("\n The postorder traversal is\n");
 postorder(root);
 return 0;
}

9)
#include <stdio.h>
#include <stdlib.h>
struct node
{
 int data;
 struct node *left;
 struct node *right;
};
typedef struct node *NODE;
NODE create_node(int item)
{
 NODE temp;
 temp=(NODE)malloc(sizeof(struct node));
 temp->data=item;
 temp->left=NULL;
 temp->right=NULL;
 return temp;
}
NODE insertleft(NODE root,int item)
{
 root->left=create_node(item);
 return root->left;
}
NODE insertright(NODE root,int item)
{
 root->right=create_node(item);
 return root->right;
}
void display(NODE root)
{
 if(root!=NULL)
 {
 display(root->left);
 printf("%d\t",root->data);
 display(root->right);
 }
}
int count_nodes(NODE root)
{
 if (root == NULL)
 return 0;
 else
 return (count_nodes(root->left) + count_nodes(root->right) + 1);
}
int height(NODE root)
{
 int leftht,rightht;
 if(root == NULL)
 return -1;
 else
 {
 leftht = height(root->left);
 rightht = height(root->right);
 if(leftht > rightht)
 return leftht + 1;
 else
 return rightht + 1;
 }
}
int leaf_nodes(NODE root)
{
 if(root==NULL)
 return 0;
 else if(root->left == NULL && root->right == NULL)
 return 1;
 else
 return leaf_nodes(root->left) + leaf_nodes(root->right);
}
int nonleaf_nodes(NODE root)
{
 if(root==NULL || (root->left == NULL && root->right == NULL))
 return 0;
 else
 return nonleaf_nodes(root->left) + nonleaf_nodes(root->right) + 1;
}
int main()
{
 NODE root=NULL;
 root=create_node(45);
 insertleft(root,39);
 insertright(root,78);
 insertleft(root->right,54);
 insertright(root->right,79);
 insertright(root->right->left,55);
 insertright(root->right->right,80);
 printf("\n The tree(inorder) is\n");
 display(root);
 printf("\n");
 printf("\n The total number of nodes is %d\n",count_nodes(root));
 printf("\n The height of the tree is %d\n",height(root));
 printf("\n The total number of leaf nodes is %d\n",leaf_nodes(root));
 printf("\n The total number of non-leaf nodes is %d\n",nonleaf_nodes(root));
 return 0;
}

10)

#include <stdio.h>
#include <stdlib.h>
struct node
{
 int data;
 struct node *left;
 struct node *right;
};
typedef struct node *NODE;
NODE create_node(int item)
{
 NODE temp;
 temp=(NODE)malloc(sizeof(struct node));
 temp->data=item;
 temp->left=NULL;
 temp->right=NULL;
 return temp;
}
NODE Insertbst(NODE root,int item)
{
 NODE temp;
 temp=create_node(item);
 if(root==NULL)
 return temp;
 else
 {
 if(item < root->data)
 root->left=Insertbst(root->left,item);
 else
 root->right=Insertbst(root->right,item);
 }
 return root;
}
void preorder(NODE root)
{
 if(root!=NULL)
 {
 printf("%d\t",root->data);
 preorder(root->left);
 preorder(root->right);
 }
}
void inorder(NODE root)
{
 if(root!=NULL)
 {
 inorder(root->left);
 printf("%d\t",root->data);
 inorder(root->right);
 }
}
void postorder(NODE root)
{
 if(root!=NULL)
 {
 postorder(root->left);
 postorder(root->right);
 printf("%d\t",root->data);
 }
}
NODE inordersuccessor(NODE root)
{
 NODE cur=root;
 while(cur->left != NULL)
 cur = cur->left;
 return cur;
}
NODE deletenode(NODE root,int key)
{
 NODE temp;
 if(root == NULL)
 return NULL;
 if(key<root->data)
 root->left = deletenode(root->left,key);
 else if(key > root->data)
 root->right = deletenode(root->right,key);
 else
 {
 if(root->left == NULL)
 {
 temp=root->right;
 free(root);
 return temp;
 }
 if(root->right == NULL)
 {
 temp=root->left;
 free(root);
 return temp;
 }
 temp=inordersuccessor(root->right);
 root->data=temp->data;
 root->right=deletenode(root->right,temp->data);
 }
 return root;
}
int main()
{
 NODE root = NULL;
 int ch,item,key;
 for(;;)
 {
 printf("\n 1. Insert");
 printf("\n 2. Preorder");
 printf("\n 3. Inorder");
 printf("\n 4. Postorder");
 printf("\n 5. Delete");
 printf("\n 6. Exit");
 printf("\n Read ur choice:");
 scanf("%d",&ch);
 switch(ch)
 {
 case 1:printf("\n Read element to be inserted :");
 scanf("%d",&item);
 root=Insertbst(root,item);
 break;
 case 2:printf("\n The Preorder traversal is\n");
 preorder(root);
break;
 case 3:printf("\n The Inorder traversal is\n");
 inorder(root);
break;
 case 4:printf("\n The Postorder traversal is\n");
 postorder(root);
break;
 case 5:printf("\n Read node to be deleted : ");
 scanf("%d",&key);
 root=deletenode(root,key);
break;
 default :exit(0);
 }
 }
 return 0;
}
