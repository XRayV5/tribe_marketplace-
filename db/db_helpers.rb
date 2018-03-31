require 'json'

def fetch_bundles
  json_path = File.expand_path('../bundles.json', __FILE__)
  file = File.read(json_path)
  JSON.parse(file)
end