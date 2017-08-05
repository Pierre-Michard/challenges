require 'json'
require_relative 'drivy'


data = JSON.parse(File.open('data.json').read)
Drivy.init_data(data)

output_file = File.open('output.json', 'w')
output_file.write(JSON.pretty_generate(Drivy.output))