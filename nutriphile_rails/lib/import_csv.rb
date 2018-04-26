# require 'rubygems'
# require 'bundler/setup'
# Bundler.require(:default)
# require 'csv'
#
# class ImportCsv
#   def read_file(read_file)
#     CSV.foreach(read_file).with_index(1) do |row, line|
#       first_line = []
#       if(line == 1)
#         first_line.push(row)
#         generate_model(*first_line)
#       else
#         # Insert data into the table create
#         # puts row[6].is_a? Date
#       end
#     end
#   end
#
#   private
#     def generate_model(*args)
#       columns = ''
#       args_str = args.join(',') #This part is necessary
#       args_str.split(',').each do |arg|
#         if arg.to_s.include?("ID") || arg.to_s.include?("Code")
#           columns += arg.to_s + ":integer "
#         elsif arg.to_s.include?("Date")
#           columns += arg.to_s + ":date "
#         else
#           columns += arg.to_s + " "
#         end
#       end
#
#       puts columns
#       ActiveRecord::Generators::ModelGenerator columns
#     end
# end

# load './lib/import_csv.rb'
# c=ImportCsv.new
# c.read_file("public/cnf-fcen-csv/FOODNAME.csv")
