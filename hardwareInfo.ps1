# Exports hardware identification information to an .html file for asset tracking

wmic computersystem get manufacturer,model /format:hform >>"C:\Users\Public\Desktop\hardwareInfo.html"
wmic bios get manufacturer,serialnumber /format:hform >>"C:\Users\Public\Desktop\hardwareInfo.html"
wmic diskdrive get model,serialNUmber,size,MediaType /format:hform >>"C:\Users\Public\Desktop\hardwareInfo.html"
