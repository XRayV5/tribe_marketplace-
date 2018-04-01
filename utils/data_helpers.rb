require 'json'
require 'csv'

def fetch_bundles
  json_path = File.expand_path('../../db/bundles.json', __FILE__)
  file = File.read(json_path)
  JSON.parse(file)
end

def read_order_csv
  csv_path = File.expand_path('../../sample_input/', __FILE__)
  Hash[ Dir[csv_path + "/**/*.{csv,xls}"].map { |path| [ path,  CSV.read(path)] } ]
end