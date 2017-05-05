DOMAINS
dr = symbol
spesialis=symbol
gejala = symbol
apa = string
jawab = char
penyakit = symbol
kondisi = cond*
cond = string

FACTS
jeneng(kondisi)
false(cond)
nama(dr,spesialis)
nama1(dr,spesialis)
nama2(dr,spesialis)
nama3(dr,spesialis)
search2(gejala)
failed2(gejala)

PREDICATES
nondeterm login
nondeterm mulai
nondeterm start				
nondeterm home
nondeterm jenis	
nondeterm thanks		
nondeterm back(char)
nondeterm dokter
nondeterm next(char)
nondeterm pilih(char)
nondeterm gangguan(penyakit)
nondeterm penyebab(penyakit)						
nondeterm hasil(char)	
nondeterm hasil1(char)					
nondeterm gejala(gejala)
nondeterm diagnosa(penyakit)
nondeterm penanganan(penyakit)
nondeterm pencegahan(penyakit)
nondeterm look(kondisi)
del
simpan(gejala,jawab)
tanya(apa,gejala,jawab)
go_once
search1(apa,gejala)
failed1(apa,gejala)
aa(char,char)
bb(char,char)



CLAUSES
	aa(Y,Y):-!.		% cut -> mencegah lacak balik
	aa(_,_):-fail.		% fail -> memaksa lacak balik

	bb(Y,Y):-!.		% cut -> mencegah lacak balik
	bb(_,_):-fail.		% fail -> memaksa lacak balik


	jeneng(["1. M. Wahid Rezky			1515015156",		%isi list
		"2. Binti Musyawirotul I.		1515015158",
		"3. Khefyn Ramadhan		1515015163",
		"4. Fitriani				1515015170"]).
	
	look([H|T]):-
			not(false(H)),
			write(H),nl,
			look(T).
	
	look([H|_]):-
			assertz(false(H)).
			

	start:-
			write("\n**********************************************************************************************************"),nl,
			write("\t\t        SISTEM PAKAR JENIS GANGGUAN PENGLIHATAN"),nl,
			write("\n**********************************************************************************************************"),nl,
			write("Nama Anggota Kelompok	: "),nl,
			jeneng(Kelompok),
			look(Kelompok),
			login.
			
	login:-
			write("\n**********************************************************************************************************"),nl,
			write("Masukkan Nama Anda 	:  "),
			readln(Nama),
			write("Alamat 		  	:  "),
			readln(Alamat),
			write("\n************************************ WELCOME TO OUR PROGRAM ***********************************"),nl,
			write("Hi, ", Nama),nl,
			write("Bertempat tinggal di ", Alamat),nl,nl,
			write("Tekan 'Y' Untuk Memulai Program\n"),
			write("Tekan 'N' Untuk Keluar\n"),
	
			readchar(A), hasil(A).			%readchar untuk membaca karakter kalo misalkan kita tekan y
			hasil(A):-aa(A,'Y'), home.		%sehingga akan melanjutkan eksekusi ke hasil
			hasil(A):-aa(A,'y'), home.		%jika kita tekan y atau Y maka akan meneruskan eksekusi ke home
			hasil(A):-aa(A,'N'), thanks.
			hasil(A):-aa(A,'n'), thanks.
			hasil(_):-login.			%jika kita tekan sembarang maka akan kembali ke start
	

      
	mulai:-
			go_once,nl,nl,nl,
        		write("Apakah Ingin mengulang lagi (Y/N) ?\n"),
        		readchar(A),hasil1(A).
			hasil1(A):-aa(A,'Y'), mulai.
			hasil1(A):-aa(A,'y'), mulai.
			hasil1(A):-aa(A,'N'), home.
			hasil1(A):-aa(A,'n'), home.
        		hasil1(_):-mulai.
	
	
	go_once:-
           		diagnosa(_),!,
           		save("test.dat"),		% menyimpan data
           		del.
            
	go_once:-
           		write("\n\n\MAAF PROGRAM KAMI TIDAK DAPAT MENYELESAIKAN PERMASALAHAN ANDA \nSilahkan Hubungi Dokter Spesialis Untuk Konsultasi Lebih Lanjut"),nl,
           		del.
            
	search1(_,Gejala):-
            		write("\nApakah "),
                        search2(Gejala),!.
            
	search1(Tanya,Gejala):-
                        not(failed2(Gejala)),
                        tanya(Tanya,Gejala,Jawab),
                        Jawab='y'.
            
	failed1(_,Gejala):-
                        failed2(Gejala),!.
            
	failed1(Tanya,Gejala):-
                        not(search2(Gejala)),
                        tanya(Tanya,Gejala,Jawab),
                        Jawab='n'.
            
	tanya(Tanya,Gejala,Jawab):-
                        write(Tanya),
                        readchar(Jawab),
                        write(Jawab),nl,
                        simpan(Gejala,Jawab).
            
	simpan(Gejala,'y'):-
                        asserta(search2(Gejala)).		% untuk menambah data
            
        simpan(Gejala,'n'):-
                        asserta(failed2(Gejala)).
            
        del:-
                        retract(search2(_)),fail.		% untuk menghapus data
            
        del:-
                        retract(failed2(_)),
                        fail.
                        del.

	
	
	home:-	
			write("\n**********************************************************************************************************"),nl,
			write("\t \t \t \t MENU UTAMA\n"),nl,
			write("1. Konsultasi Gangguan Penglihatan.\n"),
			write("2. Jenis Gangguan Penglihatan.\n"),
			write("3. Nama Dokter.\n"),
			write("4. Keluar.\n"),
			write("Piihan (1-4): \n"),

			readchar(A), pilih(A).

			pilih(A):- aa(A,'1'),mulai.
			pilih(A):- aa(A,'2'),jenis.
			pilih(A):- aa(A,'3'),dokter.
			pilih(A):- aa(A,'4'),thanks.
			pilih(_):-home.
			
			

	jenis:-	
			write("\n**********************************************************************************************************"),nl,
			write("\t \t \t JENIS - JENIS GANGGUAN PENGLIHATAN\n"),nl,
			write("1. Rabun Jauh (MIOPI).\n"),
			write("2. Rabun Dekat (HIPERMETROPI).\n"),
			write("3. Mata Tua (PRESBIOPI).\n"),
			write("4. ASTIGMATISMA.\n\n"),
			write(" Tekan 'b' untuk kembali ke menu utama\n"),

			readchar(A), next(A).

			next(A):- bb(A,'B'),home.
			next(A):- bb(A,'b'),home.
			next(_):- jenis.


/* ***************************************** NAMA - NAMA DOKTER SPESIALIS GANGGUAN PENGLIHATAN ******************************************/

nama("dr. Binti Musyawirotul Islamiyah","Menangani gangguan penglihatan rabun jauh (miopi)").
nama1("dr. Fitriani","Menangani gangguan penglihatan rabun dekat (hipermetropi)").
nama2("dr. Khefyn Ramadhan","Menangani gangguan penglihatan mata tua (presbiopi)").
nama3("dr. Wahid Rezky","Menangani gangguan penglihatan estigmatisma").

dokter:-
	write("\n**********************************************************************************************************"),nl,
	write("\t \t NAMA - NAMA DOKTER SPESIALIS GANGGUAN PENGLIHATAN\n"),nl,nl,
	nama(Nama,Spesialis),
	write("Nama		: ",Nama),nl,
	write("Spesialis		: ",Spesialis),nl,nl,

	nama1(Nam,Spes),
	write("Nama		: ",Nam),nl,
	write("Spesialis		: ",Spes),nl,nl,

	nama2(Nami,Spe),
	write("Nama		: ",Nami),nl,
	write("Spesialis		: ",Spe),nl,nl,

	nama3(Jeneng,Sp),
	write("Nama		: ",Jeneng),nl,
	write("Spesialis		: ",Sp),nl,nl,

	write(" Tekan 'b' untuk kembali ke menu utama.\n"),

	readchar(A), back(A).

	back(A):- bb(A,'B'),home.
	back(A):- bb(A,'b'),home.
	back(_):- dokter.
	
	
/* ***************************************** GEJALA - GEJALA GANGGUAN PENGLIHATAN ***************************************** */

		gejala(Gejala):-    
                        search2(Gejala),!.
                        
            	gejala(Gejala):-
                        failed2(Gejala),!,fail.

            	gejala(miopi):-
            		write("\n**********************************************************************************************************"),
                        search1(" Pandangan Anda kabur saat melihat objek jauh (y/n) ?",miopi),
                        search1(" Kepala Anda sakit (y/n) ? ",miopi1),
                        search1(" Mata Anda lelah (y/n)? ",miopi2),
                        search1(" Anda mengedipkan mata yang berlebihan (y/n)? ",miopi3),
                        search1(" Anda sering menggosok mata (y/n)? ",miopi4),
                        search1(" Anda tidak menyadari objek yang jauh (y/n)? ",miopi5).

            	gejala(hipermetropi):-
            		write("\n**********************************************************************************************************"),
                        search1(" Objek dekat tampak suram (y/n)? ",hipermetropi),
                        search1(" Anda harus mengedipakan mata untuk melihat dengan jelas (y/n)? ",hipermetropi1),
                        search1(" Kesulitan membaca (y/n)? ",hipermetropi2),
                        search1(" Mata Anda terasa panas dan gatal (y/n)? ",hipermetropi3),
                        search1(" Kepala Anda Sakit (y/n)? ",hipermetropi4).
                        
            	gejala(presbiopi):-
            		write("\n**********************************************************************************************************"),
                        search1(" Mata Anda lelah saat melihat objek yang dekat (y/n)?",presbiopi),
                        search1(" Kepala Anda sakit (y/n)? ",presbiopi1),
                        search1(" Anda mengalami kesulitan membaca tulisan kecil (y/n)? ",presbiopi2),
                        search1(" Anda menyipitkan mata saat melihat objek dekat (y/n)? ",presbiopi3),
                        search1(" Anda membutuhkan pencahayaan terang saat melihat objek yang dekat (y/n)? ",presbiopi4),
                        search1(" Anda berusaha menjauhkan objek sejauh lengan saat melihat (y/n)? ",presbiopi5).
                        
             	gejala(astigmatisma):-
             		write("\n**********************************************************************************************************"),
                        search1(" Anda kesulitan membedakan warna-warna yang letaknya bersebelahan (y/n)?",astigmatisma),
                        search1(" Anda pusing (y/n)? ",astigmatisma1),
                        search1(" Mata Anda lelah (y/n)? ",astigmatisma2),
                        search1(" Mata Anda sensitif terhadap sorotan cahaya (y/n)? ",astigmatisma3),
                        search1(" Anda kesulitan melihat gambar secara utuh (y/n)? ",astigmatisma4). 
                        


/* ***************************************** DIAGNOSA GANGGUAN PENGLIHATAN ***************************************** */

diagnosa("Rabun Jauh (Miopi)"):-
		gejala(miopi),
		gejala(miopi1),
		gejala(miopi2),
		gejala(miopi3),
		gejala(miopi4),
		gejala(miopi5),
		gangguan("Rabun Jauh (Miopi)\n"),
		penyebab("\n 1. Faktor Keturunan.\n 2. Pengaruh Lingkungan.\n"),
		penanganan("\n 1. Penggunaan kacamata. \n 2. Penggunaan lensa kontak. \n 3. Operasi dengan sinar laser. \n"),
		pencegahan("\n 1. Melindungi mata dari sinar matahari. \n 2. Memeriksa kesehatan secara rutin. \n 3. Menerapkan pola hidup sehat (khususnya vitamin A). \n 4. Mengenali gejala-gejala rabun jauh secara seksama. \n").
		
                        
diagnosa("Rabun Dekat (Hipermetropi)"):-
		gejala(hipermetropi),
		gejala(hipermetropi1),
		gejala(hipermetropi2),
		gejala(hipermetropi3),
		gejala(hipermetropi4),
		gangguan("Rabun Dekat (Hipermetropi)\n"),
		penyebab("\n 1. Faktor Keturunan. \n 2. Faktor Usia.\n"),
		penanganan("\n 1. Penggunaan kacamata. \n 2. Penggunaan lensa kontak. \n 3. Operasi. \n"),
		pencegahan("\n 1. Memeriksa kesehatan mata secara rutin. \n 2. Mengonsumsi makanan yang bernutrisi lengkap. \n 3. Menggunakan kacamata yang tepat. \n 4. Mengenali gejala gangguang pada mata. \n").
            

diagnosa("Mata Tua (Presbiopi)"):-
		gejala(presbiopi),
		gejala(presbiopi1),
		gejala(presbiopi2),
		gejala(presbiopi3),
		gejala(presbiopi4),
		gejala(presbiopi5),
		gangguan("Mata Tua (Presbiopi)\n"),
		penyebab("\n 1. Faktor usia. \n 2. Hilangnya fleksibilitas lensa alami di mata. \n"),
		penanganan("\n 1. Penggunaan kacamata kacamata tanpa resep. \n 2. Penggunaan kacamata kacamata dengan resep. \n 3. Operasi mata. \n"),
		pencegahan("\n 1. Memeriksa kesehatan mata secara rutin. \n 2. Mengonsumsi makanan yang bernutrisi lengkap. \n 3. Menggunakan kacamata yang tepat. \n 4. Mengenali gejala gangguang pada mata. \n").
		

diagnosa("Astigmatisma"):-
		gejala(astigmatisma),
		gejala(astigmatisma1),
		gejala(astigmatisma2),
		gejala(astigmatisma3),
		gejala(astigmatisma4),
		gangguan("Astigmatisma\n"),
		penyebab("\n 1. Komplikasi akibat operasi mata.\n 2. Cedera pada kornea akibat infeksi.\n 3. Kondisi pada kelopak mata yang menunggu struktur kornea.\n 4. Kondisi dimana kornea mata dapat berubah bentuk.\n"),
		penanganan("\n 1. Penggunaan kacamata. \n 2. Penggunaan lensa kontak. \n 3. Terapi alami mata. \n 4. Operasi mata. \n"),
		pencegahan("\n 1. Melakukan olah raga mata. \n 2. Melakukan kompres dengan air hangat. \n 3. Jangan menggunakan bantal,handuk,atau guling orang lain.\n").


gangguan(Penyakit):-
		write("\n**********************************************************************************************************"),
		write("\nGangguan Penglihatan Yang Anda Alami : ",Penyakit).


penyebab(Penyakit):-
		write("\nPenyebab : ",Penyakit).
	

penanganan(Penyakit):-
		write("\nPenanganan : ",Penyakit).
	

pencegahan(Penyakit):-
		write("\nPencegahan : ",Penyakit),
		write("\n**********************************************************************************************************").
	
thanks:-
   		write("\n**********************************************************************************************************"),
 		write("\n\t          TERIMA KASIH, ANDA TELAH MENGGUNAKAN PROGRAM KAMI\n"),
		write("\t\t\t\t  KEEP HEALTH\n"),
		write("\n**********************************************************************************************************\n").


GOAL
start.