# how to print a pdf label from command line

- first pre-configure the printer with standard settings by accessing the driver first from the system menu and preload the settings
- then send the file (probably best to use the first option to make sure the right printer is selected and the right options are set)

Print a PDF file with dialog:

    AcroRd32.exe /P PdfFile
Print a PDF file silently:

    AcroRd32.exe /N /T PdfFile PrinterName [ PrinterDriver [ PrinterPort ] ]

http://www.robvanderwoude.com/commandlineswitches.php#Acrobat


/n - Launch a new instance of Reader even if one is already open
/s - Don't show the splash screen
/o - Don't show the open file dialog
/h - Open as a minimized window
/p <filename> - Open and go straight to the print dialog
/t <filename> <printername> <drivername> <portname> - Print the file the specified printer.

https://stackoverflow.com/questions/619158/adobe-reader-command-line-reference?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa

ZPL

- all is ASCII code compatible: images need to be transformed into hexadecimal code 
- free tool available from Zebra
- but could use an R library
- important: the printer can preload images into the memory for efficiency: do that for logo
- so, in the end just copy the file to the zebra printer

https://www.zebra.com/us/en/support-downloads/knowledge-articles/using-zpl-stored-formats.html
https://developer.zebra.com/thread/30717
https://www.zebra.com/content/dam/zebra/manuals/printers/common/zpl-zbi2-pm-en.pdf





