#########################
# CSV File - id integer, col1 text, col2 text, col3 integer
# Can append lines without allowing duplicate IDs or all duplicate data (col1, col2, col3 all the same as another row)
# Can find a line by the ID
#########################

#########################
# Open file with mode "a" to append
# Open file mode "r" to read
# Make sure open and close file before and after reading or writing.
#########################

###################################################
# This is the section that needs refactoring
# If this is too long, you could also just 
# focus on the add_line method.
###################################################
###################################################
###################################################
class FileCRUD
  # Should append a line without allowing duplicate IDs or duplicate data
  def add_line(fnme, id, t1, t2, i2)
    file = File.new(fnme, "r+")
    i = false
    
    begin
      while(line = file.readline)
        if(line.chomp.split(",")[0].to_i == id)
          print "Can't have duplicate IDs!\n"
          
          i = true
        end
      end
    rescue EOFError
    end
    
    file.rewind
    
    begin
      while(line = file.readline)
        if((line.chomp.split(",")[1] == t1) && (line.chomp.split(",")[2] == t2) && (line.chomp.split(",")[3].to_i == i2))
          print "You shouldn't insert a duplicate record!\n"
          
          i = true
        end
      end
    rescue EOFError
    end
    
    if(!i)
      file << "#{id},#{t1.gsub(",", "_")},#{t2.gsub(",", "_")},#{i2}\n" # Append line to end of file.
    end
    
    closef(file)
  end
  
  # Should return the line matching the id, or a blank array if ID doesn't exist
  def line(file, id)
    f = openfile(file)
    
    lns = get_file_lines(f)
    
    myln = Array.new
    
    lns.each do |ln|
      if(ln.split(",")[0].to_i == id)
        myln = ln.split(",")
      end
    end
    
    return myln
  end
  
  private
    def openfile(f_n)
      return File.new(f_n, "r")
    end
    
    def closef(f)
      f.close
    end
    
    def get_file_lines(f)
      l = Array.new()

      begin
        while(ln = f.readline)
          l << ln.chomp
        end
      rescue EOFError
      end

      closef(f)

      return l
    end
end

###################################################
###################################################
###################################################
############### Sample Usage ######################
###################################################
###################################################
###################################################

if(File.exists?("./test_file.txt"))
  File.delete("./test_file.txt")
end

File.new("./test_file.txt", "w").close()

loFile = FileCRUD.new()

loFile.add_line("./test_file.txt", 1, "two", "three", 5)
loFile.add_line("./test_file.txt", 2, "two1", "three2", 7)
loFile.add_line("./test_file.txt", 6, "two", "three", 5)
loFile.add_line("./test_file.txt", 8, "fout", "tfoo", 4)
loFile.add_line("./test_file.txt", 2, "baz", "bar", 4)
loFile.add_line("./test_file.txt", 5, "test", "test2", 4)

print "\n#{"ID".ljust(10, " ")} | #{"Col1".ljust(10, " ")} | #{"Col2".ljust(10, " ")} | #{"Col3".ljust(10, " ")}\n"
print "#{"-"*40}-----------\n"

laLine = loFile.line("./test_file.txt", 2)
print "#{laLine[0].to_s.ljust(10, " ")} | #{laLine[1].to_s.ljust(10, " ")} | #{laLine[2].to_s.ljust(10, " ")} | #{laLine[3].to_s.ljust(10, " ")}\n"

laLine = loFile.line("./test_file.txt", 6)
print "#{laLine[0].to_s.ljust(10, " ")} | #{laLine[1].to_s.ljust(10, " ")} | #{laLine[2].to_s.ljust(10, " ")} | #{laLine[3].to_s.ljust(10, " ")}\n"

laLine = loFile.line("./test_file.txt", 5)
print "#{laLine[0].to_s.ljust(10, " ")} | #{laLine[1].to_s.ljust(10, " ")} | #{laLine[2].to_s.ljust(10, " ")} | #{laLine[3].to_s.ljust(10, " ")}\n\n"