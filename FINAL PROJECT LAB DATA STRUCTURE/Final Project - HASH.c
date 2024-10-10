#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <conio.h>
#include <windows.h>

#define HASH_SIZE 1007

// Iqbal Rafi Maulana - 2602134595
// Marvel Stefano - 2602067792
// Zelos Mikhael Mahanaim - 2602207350

struct student
{

    char name[100];
    char gender[10];
    char major[100];
    char NIM[12];
    int year;

    struct student* next;
    struct student* previous;
};

struct student* hashTable[HASH_SIZE];

int lastId = 0;

int getCurrentYear()
{
    time_t t = time(NULL);
    struct tm *now = localtime(&t);
    return now->tm_year + 1900;
}

char* generateStudentID(int year, char gender[], int major) {
    char* studentID = malloc(sizeof(char) * 11);
    int studentYear = year % 100;
    int genderCode = (gender[0] == 'M') ? 1 : 2;

    // Construct the student ID
    sprintf(studentID, "%02d%02d%02d%04d", studentYear, genderCode, major, rand() % 10000);

    return studentID;
}

void insert()
{
	char name[100], gender[10], major[100];
	int year, majorid;
	int currentYear = getCurrentYear();
	struct student* current = hashTable[lastId % HASH_SIZE];
    
	do
	{
        printf("Input Student Name[>3]: ");
        fgets(name, 100, stdin);
        if(strlen(name) == 50)
        {
        	getchar();
		}
        name[strcspn(name, "\n")] = '\0';
    } while (strlen(name) < 3);
    
    do
	{	
        printf("Input Student Gender (Male/Female): ");
        fgets(gender, 10, stdin);
        gender[strcspn(gender, "\n")] = '\0';
    } while (strcmp(gender, "male") != 0 && strcmp(gender, "female") != 0 && strcmp(gender, "Male") != 0 && strcmp(gender, "Female") != 0 && strcmp(gender, "MALE") != 0 && strcmp(gender, "FEMALE") != 0);

	do
	{
        printf("Enter student's class year: ");
        scanf("%d", &year);
        getchar();

        if (year > currentYear + 4)
		{
            printf("Invalid year. Please enter again.\n");
        } else if (year < 2000)
		{
            printf("Year should be greater than or equal to 2000. Please enter again.\n");
        }
    } while (year > currentYear + 4 || year < 2000);
    
    printf("Choose Student Major :\n");
	printf("1. Computer Science\n");
	printf("2. Visual Communication Design\n");
	printf("3. Interior Design\n");
	printf("4. Public Relation\n");
	printf("5. Communication\n");
	printf("6. Enterpreneurship Bussiness Creation\n");
	printf("Input Major Number (1-6): ");
	scanf("%d", &majorid);
	
	if(majorid==1)
	{
		strcpy(major, "Computer Science");
	}
	else if(majorid==2)
	{
		strcpy(major, "Visual Communication Design");
	}
	else if(majorid==3)
	{
		strcpy(major, "Interior Design");
	}
	else if(majorid==4)
	{
		strcpy(major, "Public Relation");
	}
	else if(majorid==5)
	{
		strcpy(major, "Communication");
	}
	else if(majorid==6)
	{
		strcpy(major, "Enterpreneurship Bussiness Creation");
	}
	
	printf("Major = %s\n", major);
	
	srand(time(NULL));
	char* studentID = generateStudentID(year, gender, majorid);
    printf("Student NIM: %s\n", studentID);
    
    struct student* newNode = (struct student*) malloc(sizeof(struct student));
    strcpy(newNode->name, name);
    strcpy(newNode->gender, gender);
    strcpy(newNode->major, major);
    strcpy(newNode->NIM, studentID);
    newNode->year = year;
    newNode->next = NULL;

    int key = 0;
    int i;
    for (i = 0; i < strlen(studentID); i++)
	{
        key += (int) studentID[i];
    }
    key %= HASH_SIZE;
    if (hashTable[key] == NULL)
	{
        hashTable[key] = newNode;
    } 
	else
	{
        current = hashTable[key];
        while (current->next != NULL)
		{
            current = current->next;
        }
        current->next = newNode;
    }
	free(studentID);
    printf("Insert success !\n");
}



void printHashTable(struct student* hashTable[], int size) 
{
    int i;
    int isEmpty = 1;
    for (i = 0; i < size; i++) {
        if (hashTable[i] != 0) {
            isEmpty = 0; // not empty
            break;
        }
    }
    if (isEmpty) {
        printf("There is no data(s) !\n");
    } else {
        printf("-----------------------------------------------------------------------------------------------------------------------------------\n");
    	printf("| %-50s | %-10s | %-25s | %-13s | %-3s\n", "Name", "Gender", "Major", "NIM", "Year");
    	printf("-----------------------------------------------------------------------------------------------------------------------------------\n");   
    }
	
    for (i = 0; i < size; i++)
	{
		if (hashTable[i] != NULL)
		{
            struct student* current = hashTable[i];
            while (current != NULL)
			{
                printf("| %-50s | %-10s | %-25s | %-13s | %-3d\n", current->name, current->gender, current->major, current->NIM, current->year);
    			printf("-----------------------------------------------------------------------------------------------------------------------------------\n"); 
                current = current->next;
            }
        }
    }
}

void removedata()
{
    char NIM[12];
    printf("Input student NIM to delete: ");
    fgets(NIM, 12, stdin);
    NIM[strcspn(NIM, "\n")] = '\0';

    int key = 0;
    int i;
    for (i = 0; i < strlen(NIM); i++)
    {
        key += (int) NIM[i];
    }
    key %= HASH_SIZE;

    struct student* current = hashTable[key];
    struct student* previous = NULL;
    while (current != NULL)
    {
        if (strcmp(NIM, current->NIM) == 0)
        {
            if (previous == NULL)
            {
                hashTable[key] = current->next;
            }
            else
            {
                previous->next = current->next;
            }
            char x;
            printf("Student Name: %s\n", current->name);
            printf("Student Gender: %s\n", current->gender);
            printf("Student Major: %s\n", current->major);
            printf("Student NIM: %s\n", current->NIM);
            printf("Student Graduation Year: %d\n", current->year);
            do
            {
            	printf("Are you sure [y|n]? ");
	            x  = getchar();
	            if(x=='y')
	            {
	            	free(current);
	            	printf("Delete success !\n");
	            	return;
	            	previous = current;
        			current = current->next;
				}
	            else if(x=='n')
				{
					return;
				}
			}while(x != 'y' || x != 'n');
        }
    }
    printf("Student not found !\n");
}

void home()
{
	char c;
	printf("\n\n\t\t\t\t\tWelcome to Student ID Generator\n");
	printf("\n\t\t\t\t\tClick Enter to continue...");
	c = getchar();
}

void loading1(){
	printf("\n\n\n\n\n\n\n\n\n\n");
    printf("\n\n\n\t\t\t\t\t       Loading.....");
    printf("\n\n");
    printf( "\t\t\t\t ");
    for (int i=0; i<= 35; i++)
    {
        printf("%c", 178);
        Sleep(20);
    }
    system ("cls");
}

void search()
{
    char NIM[12];
    printf("Input NIM to search: ");
    fgets(NIM, 12, stdin);
    NIM[strcspn(NIM, "\n")] = '\0';

    int key = 0;
    int i;
    for (i = 0; i < strlen(NIM); i++)
    {
        key += (int)NIM[i];
    }
    key %= HASH_SIZE;

    struct student* current = hashTable[key];
    while (current != NULL)
    {
        if (strcmp(NIM, current->NIM) == 0)
        {
            printf("Student Name: %s\n", current->name);
            printf("Student Gender: %s\n", current->gender);
            printf("Student Major: %s\n", current->major);
            printf("Student NIM: %s\n", current->NIM);
            printf("Student Graduation Year: %d\n", current->year);
            return;
        }
        current = current->next;
    }
    printf("Student not found !\n");
}

void searchByName()
{
    char name[100];
    printf("Enter the student name to search: ");
    fgets(name, 100, stdin);
    name[strcspn(name, "\n")] = '\0';

    int found = 0;
    for (int i = 0; i < HASH_SIZE; i++)
    {
        struct student* current = hashTable[i];
        while (current != NULL)
        {
            if (strcmp(name, current->name) == 0)
            {
                printf("Student Name: %s\n", current->name);
                printf("Student Gender: %s\n", current->gender);
                printf("Student Major: %s\n", current->major);
                printf("Student NIM: %s\n", current->NIM);
                printf("Student Graduation Year: %d\n", current->year);
                found = 1;
            }
            current = current->next;
        }
    }

    if (!found)
    {
        printf("Student not found!\n");
    }
}

void searchByMajor()
{
    char major[100];
    printf("Enter the student major to search: ");
    fgets(major, 100, stdin);
    major[strcspn(major, "\n")] = '\0';

    int found = 0;
    for (int i = 0; i < HASH_SIZE; i++)
    {
        struct student* current = hashTable[i];
        while (current != NULL)
        {
            if (strcmp(major, current->major) == 0)
            {
                printf("Student Name: %s\n", current->name);
                printf("Student Gender: %s\n", current->gender);
                printf("Student Major: %s\n", current->major);
                printf("Student NIM: %s\n", current->NIM);
                printf("Student Graduation Year: %d\n", current->year);
                found = 1;
            }
            current = current->next;
        }
    }

    if (!found)
    {
        printf("Student not found!\n");
    }
}


void searching(){
	int pilihan;
	do{
	
	printf("\nSearch based on :\n");
	printf("1. NIM\n");
	printf("2. Name\n");
	printf("3. Major\n");
	printf("4. Back to Main Menu\n\n");
	printf("Choose menu : ");
	scanf("%d", &pilihan);
	getchar();
	switch (pilihan){
		case 1:{
			search();
			system("cls");
			break;
		}
		case 2:{
			searchByName();
			system("cls");
			break;
		}
		case 3:{
			searchByMajor();
			system("cls");
			break;
	}
}
} while (pilihan != 4);
}

int main()
{
    char c;
    int y;
	struct student *hash[HASH_SIZE] = { NULL };
	home();
	loading1();
	do
	{
		printf("\n\t\t\t\t\tWelcome to Bina Nusantara Student Database");
		printf("\n\n\nBina Nusantara Student Database Main Menu\n");
		printf("=================\n");
		printf("1. View Student NIM\n");
		printf("2. Insert Student NIM\n");
		printf("3. Remove Student NIM\n");
		printf("4. Search\n");
		printf("5. EXIT\n");
		printf("Choose Menu : ");
		scanf("%d", &y);
		getchar();
		system("cls");
		if(y==1)
		{
			printHashTable(hashTable, HASH_SIZE);
		}
		else if(y==2)
		{
			insert(); 
		}
		else if(y==3)
		{
			removedata();
		}
		else if(y==4)
		{
			searching();
		}
		else if(y==5)
	    {
	    	return 0;
		}
		printf("\nPress enter to conmmmtinue...\n");
		c = getchar();
		system("cls");
	} while (c == '\n');
}