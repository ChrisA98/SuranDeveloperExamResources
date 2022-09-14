#!/usr/bin/env python
# -*- coding: utf-8 -*-
##Christopher Adkins
##-sort a list of names and write to a file
import os.path

##ImportRelFile##
def ImportRelFile(fileName):
    # check if sort me.txt exists in current context
    if(os.path.exists(fileName) == False):
        raise ImportError(fileName+" is not located in this folder")

    ##Read File and write to variable##
    listFile = open(fileName)
    listBase = listFile.readlines()
    length = len(listBase)
    ##Strip Line Breaks from items
    for ind in range(length):
        if(listBase[ind][-1:]== '\n'):
            listBase[ind] = listBase[ind][:-1]
            
    ##Strip spaces from end of items
    for ind in range(length):
        if(listBase[ind][-1:]== ' '):
            listBase[ind] = listBase[ind][:-1]
            
    ##Strip spaces from beginning of items
    for ind in range(length):
        if(listBase[ind][:1]== ' '):
            listBase[ind] = listBase[ind][1:]
            
    ##Remove empty entries
    while('' in listBase):
        listBase.remove('')
    listFile.close()
    return listBase
##End ImportRelFile##

##WriteFormattedFile##
def WriteFormattedFile(filename, arr):
    fileOut = open(filename,"w")
    ##Add line rbeak to every item except last item
    for ind in range(len(arr)-1):
        arr[ind] = arr[ind]+" \n"
    fileOut.writelines(arr)
    fileOut.close()
##End WriteFormattedFile##

##Sort Elements by length
def SortList(arr):
    out = sorted(arr)  ##Sort List alphabetically
    length = len(out)    
    for i in range(length):
        for j in range(0,length-i-1):
            if ( len(out[j]) > len(out[j+1])):
               out[j], out[j+1] = out[j+1], out[j]
    return out
##End lengthBubSort

##PrintList##
def PrintList(arr):
    length = len(arr)
    for ind in range(length):
        print(arr[ind])
##End PrintList##    

##Run Program 
origList = ImportRelFile("Sort Me.txt")
outList = SortList(origList)
PrintList(outList)
WriteFormattedFile('Sorted.txt', outList)
input("File sorted, press Enter to close...")
