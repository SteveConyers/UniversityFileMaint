# UniversityFileMaint
Interactive File Maintenance

This is a project that was created during my advanced RPG course in college.

This is an interactive program that allows the user to add, delete or modify records. It uses data validation, date conversion and error messaging.

This program was created using IBM RDi. You can now also use Visual Studio Code to create RPGLE programs using the extension "Code for IBM i". Another extension I recommend is "Db2 for IBM i".
Using the files or the code from the files, one is the display file and the other is the source code. (CIS270P6.DSPF and CIS270P6.RPGLE)
You can then use the files themselves or copy and paste into new files.
You then need to compile each file. Once compiled, then use the 5250 emulator can CALL the program, by typing "CALL CIS270P6" and then press enter key.
PS: Don't use the quotation makes and you do not have to use capital letters.

Program should open up to a screen where you can type in a social security number, and action code. A,C or D.
A is to add
C is to change
D is to delete

A can only happen if the social security number you enter does not already exist in the "database".
C and D can only happen if the record does exist.

If A is selected and the program is exited without pressing the Enter key, then the record will not be saved.
IF C or D is selected, the record can only be modified or deleted, if the correct key is pressed. If not, such as deciding to cancel (F12) or F3 to exit the program entirely, then the changes with not be saved or record will not be removed depending on the option selected.

This program can be tied to a spreadsheet file by just changing the name of the file I used in the CIS270P6 display file. That way you could even create and modify your own "database".
