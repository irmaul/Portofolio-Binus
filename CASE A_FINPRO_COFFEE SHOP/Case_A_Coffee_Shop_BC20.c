/*Case A - Coffee Shop - BC20
Daniel Hendra Susanto - 2602102145
Ezra Aufaa Malefa - 2602087402
Iqbal Rafi Maulana - 2602134595*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

struct penjualan{
	int tanggal, bulan, tahun;
	char nama[100];
	int jenismenu; //jenismenu
	int pilihanmenu; //pilihanmenu
	int jumlahitem;//jumlahitem
	int hargamenu;//hargamenu
	int total;//total pembayaran
};

struct hargamakan{
	int cap;
	int lat;
	int amer;
	int mat;
	int choc;
	int red;
	int fries;
	int mush;
	int tofu;
};

void entry(){
	struct hargamakan hg[9];
	FILE *fptr;
		fptr = fopen ("hrgmakan.txt", "r");
		for (int i = 1; i <= 3; i++){
			fscanf(fptr,"%d %d %d %d %d %d %d %d %d", &hg[i].cap, &hg[i].lat, &hg[i].amer,&hg[i].mat,&hg[i].choc,&hg[i].red,&hg[i].fries,&hg[i].mush,&hg[i].tofu );
		}
		fclose(fptr);
		
	struct penjualan awal[100];
	int i =0;
	char cekInput;
	FILE *fp;
	
	int subMenu;
	printf("======================================================== Cashier =======================================================\n\n");
	printf("1. Tambah data penjualan\n");
	printf("0. Kembali ke Main Menu\n\n");
	printf("Pilihan Menu : ");
	scanf("%d", &subMenu);
	if (subMenu == 1){
		fp = fopen("sales.txt", "a");
		fptr = fopen ("salesFIX.txt", "a");
	}
	if (subMenu == 0){
		goto exit;
	}
	do{
		printf("\n");
	do{
		printf("Tanggal Transaksi (dd/mm/yyyy) : ");
		scanf("%d/%d/%d", &awal[i].tanggal, &awal[i].bulan, &awal[i].tahun);
		if(awal[i].tanggal>31 || awal[i].bulan>12){
		printf("!!! Tanggal Invalid !!!\n");
		}
	}while(awal[i].tanggal>31 || awal[i].bulan>12);
	printf("Nama : ");
		scanf("\n%[^\n]", &awal[i].nama);
	do{
			printf("Jenis Pemesanan :\n");
			printf("\t1. Take Away \n");
			printf("\t2. Dine In\n");
			printf("Pilihan : ");
				scanf("%d", &awal[i].jenismenu);
					if(awal[i].jenismenu < 1 || awal[i].jenismenu > 2){
					printf("			Invalid input\n"); }
	}while(awal[i].jenismenu < 1 || awal[i].jenismenu > 2);
	do{
		printf("Menu :\n");
			printf("\t 1. Cappucino\t 			Rp %d\n", hg[awal[i].jenismenu].cap);
			printf("\t 2. Latte\t 			Rp %d\n", hg[awal[i].jenismenu].lat);
			printf("\t 3. Americano\t 			Rp %d\n", hg[awal[i].jenismenu].amer);
			printf("\t 4. Matcha\t 			Rp %d\n", hg[awal[i].jenismenu].mat);
			printf("\t 5. Chocolate\t 			Rp %d\n", hg[awal[i].jenismenu].choc);
			printf("\t 6. Redvelvet\t 			Rp %d\n", hg[awal[i].jenismenu].red);
			printf("\t 7. French Fries\t		Rp %d\n", hg[awal[i].jenismenu].fries);
			printf("\t 8. Fried Mushroom\t 		Rp %d\n", hg[awal[i].jenismenu].mush);
			printf("\t 9. Fried Tofu\t 			Rp %d\n", hg[awal[i].jenismenu].tofu);
			printf("Pilihan item : "); 
				scanf("%d", &awal[i].pilihanmenu);
			if(awal[i].pilihanmenu < 1 || awal[i].pilihanmenu > 9){
				printf("			Invalid input\n");
			}
	}while(awal[i].pilihanmenu < 1 || awal[i].pilihanmenu > 9);
	printf("Jumlah item : ");
		scanf("%d", &awal[i].jumlahitem);
		if(awal[i].pilihanmenu == 1) awal[i].hargamenu = hg[awal[i].jenismenu].cap;
		else if(awal[i].pilihanmenu == 2) awal[i].hargamenu = hg[awal[i].jenismenu].lat;
		else if(awal[i].pilihanmenu == 3) awal[i].hargamenu = hg[awal[i].jenismenu].amer;
		else if(awal[i].pilihanmenu == 4) awal[i].hargamenu = hg[awal[i].jenismenu].mat;
		else if(awal[i].pilihanmenu == 5) awal[i].hargamenu = hg[awal[i].jenismenu].choc;
		else if(awal[i].pilihanmenu == 6) awal[i].hargamenu = hg[awal[i].jenismenu].red;
		else if(awal[i].pilihanmenu == 7) awal[i].hargamenu = hg[awal[i].jenismenu].fries;
		else if(awal[i].pilihanmenu == 8) awal[i].hargamenu = hg[awal[i].jenismenu].mush;
		else if(awal[i].pilihanmenu == 9) awal[i].hargamenu = hg[awal[i].jenismenu].tofu;
	
	awal[i].total = awal[i].hargamenu * awal[i].jumlahitem;
	
	fprintf(fp, "%d,%d,%d,%s,%d,%d,%d,%d,%d\n", awal[i].tanggal, awal[i].bulan, awal[i].tahun, awal[i].nama, awal[i].jenismenu, awal[i].pilihanmenu, awal[i].jumlahitem, awal[i].hargamenu, awal[i].total);	
	
	fprintf(fptr,"Tanggal Transaksi: %02d / %02d / %d\n", awal[i].tanggal, awal[i].bulan, awal[i].tahun);
	fprintf(fptr,"Atas Nama: %s\n", awal[i].nama);
	switch(awal[i].jenismenu){
			case 1:
				fprintf(fptr,"Jenis Pemesanan yang dipilih : Take Away\n");
				break;
			case 2:
				fprintf(fptr,"Jenis Pemesanan yang dipilih : Dine in\n");
				break;
		}
	switch(awal[i].jumlahitem){
			case 1:
				fprintf(fptr,"Cappucino x%d\n", awal[i].jumlahitem);
				break;
			case 2:
				fprintf(fptr,"Latte x%d\n", awal[i].jumlahitem);
				break;
			case 3:
				fprintf(fptr,"Americano x%d\n", awal[i].jumlahitem);
				break;
			case 4:
				fprintf(fptr,"Matcha x%d\n", awal[i].jumlahitem);
				break;
			case 5:
				fprintf(fptr,"Chocolate x%d\n", awal[i].jumlahitem);
				break;
			case 6:
				fprintf(fptr,"Redvelvet x%d\n", awal[i].jumlahitem);
				break;
			case 7:
				fprintf(fptr,"Fries x%d\n", awal[i].jumlahitem);
				break;
			case 8:
				fprintf(fptr,"Mush x%d\n", awal[i].jumlahitem);
				break;
			case 9:
				fprintf(fptr,"Tofu x%d\n", awal[i].jumlahitem);
				break;
		}
	fprintf(fptr,"Total Biaya: %d\n", awal[i].total);
		fprintf(fptr,"\n");
	printf("Apakah anda ingin menginput data lagi?(Y/N) : ");
	scanf("\n%c", &cekInput);
	i++;
	}while(toupper(cekInput) != 'N');
	
	fclose(fp);
	fclose(fptr);
	exit:
		
	getchar();
	printf("\nPress ENTER to go back to main menu...\n");
	getchar();
}

void sort(){
	struct penjualan sorted[100], temp;
	FILE *fp;
	fp = fopen("sales.txt","r");
	if(fp == NULL){
		printf("Warning!!! Program gagal membaca file\n");
		exit(1);
	}
	printf("======================================================== Sorting =======================================================\n");
	
	printf("\nLaporan Penjualan Berdasarkan : \n");
	
	int i=0;
	while(fscanf(fp,"%d,%d,%d,%[^','],%d,%d,%d,%d,%d", 
	&sorted[i].tanggal, &sorted[i].bulan, &sorted[i].tahun, &sorted[i].nama, &sorted[i].jenismenu, &sorted[i].pilihanmenu, &sorted[i].jumlahitem, &sorted[i].hargamenu, &sorted[i].total) != EOF){
		i++;
	}
	
	int pilihan;
	printf("1. Total Pembayaran \n");
	printf("2. Tanggal pembelian Terbaru/ Terlama\n");
	printf("\nPilih Menu : ");
	scanf("%d", &pilihan);
	printf("\n");
	
	if(pilihan == 1){
		for(int j=0; j<i; j++){
			for(int k=0; k<i-1; k++){					
						if(sorted[k].total > sorted[k+1].total){
							temp = sorted[k];
							sorted[k] = sorted[k+1];
							sorted[k+1] = temp;
						}
					}
				}
		}	
	else if(pilihan == 2){
		int memilih;
		system("cls");
		printf("Sorting Pembelian Berdasarkan :\n");
		printf("1. Tanggal Terbaru\n");
		printf("2. Tanggal terlama\n");
		printf("\nPilih Menu : ");
		scanf("%d", &memilih);
		if(memilih ==1){
			for(int j=0; j<i; j++){
			for(int k=0; k<i-1; k++){
				if(sorted[k].tahun < sorted[k+1].tahun){
					temp = sorted[k];
					sorted[k] = sorted[k+1];
					sorted[k+1] = temp;
				}
				else if(sorted[k].tahun == sorted[k+1].tahun){
					if(sorted[k].bulan < sorted[k+1].bulan){
						temp = sorted[k];
						sorted[k] = sorted[k+1];
						sorted[k+1] = temp;
					}
					else if(sorted[k].bulan == sorted[k+1].bulan){
						if(sorted[k].tanggal < sorted[k+1].tanggal){
							temp = sorted[k];
							sorted[k] = sorted[k+1];
							sorted[k+1] = temp;
						}
					}
				}
			}
		}
		}
		else if ( memilih == 2){
			for(int j=0; j<i; j++){
			for(int k=0; k<i-1; k++){
				if(sorted[k].tahun > sorted[k+1].tahun){
					temp = sorted[k];
					sorted[k] = sorted[k+1];
					sorted[k+1] = temp;
				}
				else if(sorted[k].tahun == sorted[k+1].tahun){
					if(sorted[k].bulan > sorted[k+1].bulan){
						temp = sorted[k];
						sorted[k] = sorted[k+1];
						sorted[k+1] = temp;
					}
					else if(sorted[k].bulan == sorted[k+1].bulan){
						if(sorted[k].tanggal > sorted[k+1].tanggal){
							temp = sorted[k];
							sorted[k] = sorted[k+1];
							sorted[k+1] = temp;
						}
					}
				}
			}
		}	
	}
	else{
		printf("!!! Pilihan yang anda masukkan salah !!!\n\n");
		goto exit;
	}
	}
	
	else{
		printf("!!! Pilihan yang anda masukkan salah !!!\n\n");
		goto exit;
	}
	for(int j=0; j<i; j++){
		printf("Tanggal : %d/%d/%d\n", sorted[j].tanggal, sorted[j].bulan, sorted[j].tahun);
		printf("Nama : %s\n", sorted[j].nama);
		printf("Jenis Pemesanan : ");
		if(sorted[j].jenismenu==1) printf("Take Away\n");
		else if(sorted[j].jenismenu==2) printf("Dine in\n");
		printf("Jenis Item : ");
		if(sorted[j].pilihanmenu==1) printf("Cappucino\n");
		else if(sorted[j].pilihanmenu==2) printf("Latte\n");
		else if(sorted[j].pilihanmenu==3) printf("Americano\n");
		else if(sorted[j].pilihanmenu==4) printf("Matcha\n");
		else if(sorted[j].pilihanmenu==5) printf("Chocolate\n");
		else if(sorted[j].pilihanmenu==6) printf("Redvelvet\n");
		else if(sorted[j].pilihanmenu==7) printf("French Fries\n");
		else if(sorted[j].pilihanmenu==8) printf("Fried Mushroom\n");
		else if(sorted[j].pilihanmenu==9) printf("Fried Tofu\n");
		printf("Jumlah Item : %d\n", sorted[j].jumlahitem);
		printf("Harga Item : Rp %d\n", sorted[j].hargamenu);
		printf("Total Pembayaran : Rp.%d\n", sorted[j].total);
		printf("\n");
	}
	
	exit:
	fclose(fp);
	
	getchar();
	printf("Press ENTER to go back to main menu...\n");
	getchar();
}

void search(){
	struct penjualan sorted[100], temp; 
	FILE *fp;
	fp = fopen("sales.txt","r");
	if(fp == NULL){
		printf("Warning!!! Program gagal membaca file\n");
		exit(1);
	}
	
	printf("====================================================== Search Data ====================================================\n\n");
	
	int i=0;
	while(fscanf(fp,"%d,%d,%d,%[^','],%d,%d,%d,%d,%d", 
	&sorted[i].tanggal, &sorted[i].bulan, &sorted[i].tahun, &sorted[i].nama, &sorted[i].jenismenu, &sorted[i].pilihanmenu, &sorted[i].jumlahitem, &sorted[i].hargamenu, &sorted[i].total) != EOF){
		i++;
	}
	
	int cari;
	printf("Pilihan Metode Pemesanan :\n");
	printf("\t 1. Take Away\n");
	printf("\t 2. Dine in\n");
	printf("Search metode pemesanan : ");
	scanf("%d", &cari);
	printf("\n");
	
	int result, arr[10];
	char pilihan;
	for(int j=0; j<i; j++){
		if(sorted[j].jenismenu==cari){
			printf("Tanggal : %d/%d/%d\n", sorted[j].tanggal, sorted[j].bulan, sorted[j].tahun);
			printf("Nama : %s\n", sorted[j].nama);
			printf("Nama metode pemesanan : ");
			if(sorted[j].jenismenu==1) printf("Take Away\n");
			else if(sorted[j].jenismenu==2) printf("Dine in\n");
			printf("Jenis item : ");
			if(sorted[j].pilihanmenu==1) printf("Cappucino\n");
			else if(sorted[j].pilihanmenu==2) printf("Latte\n");
			else if(sorted[j].pilihanmenu==3) printf("Americano\n");
			else if(sorted[j].pilihanmenu==4) printf("Matcha\n");
			else if(sorted[j].pilihanmenu==5) printf("Chocolate\n");
			else if(sorted[j].pilihanmenu==6) printf("Redvelvet\n");
			else if(sorted[j].pilihanmenu==7) printf("French Fries\n");
			else if(sorted[j].pilihanmenu==8) printf("Fried Mushroom\n");
			else if(sorted[j].pilihanmenu==9) printf("Fried Tofu\n");
			printf("Jumlah item : %d\n", sorted[j].jumlahitem);
			printf("Harga item : Rp.%d\n", sorted[j].hargamenu);
			printf("Total Pembayaran : Rp.%d\n", sorted[j].total);
			printf("\n");
			arr[j] = result++;
		}
	}
	if(result == 0){
		printf("Data Not Found\n");
	}
	fclose(fp);
	
	getchar();
	printf("Press ENTER to go back to main menu...\n");
	getchar();
}

int main(){
	
	int pilihan;
	
	do{
		system("cls");
		printf("====================================================== Coffee Shop =====================================================\n");
		printf("\n1. Input Data Penjualan\n");
		printf("2. Sorting Data Penjualan \n");
		printf("3. Search Data Berdasarkan Jenis Pemesanan\n");
		printf("0. Exit\n");
		printf("\n");
		
		printf("Pilih Menu : ");
		scanf("%d", &pilihan);
		switch(pilihan){
			case 1:{
				system("cls");
				entry();
				break;
			}
			case 2:{
				system("cls");
				sort();
				break;
			}
			case 3:{
				system("cls");
				search();
				break;
			}	
		}
	}
	while(pilihan != 0);
	return 0;
}
