require 'json'

method = ARGV[1] || 'GET'
filename = "caches/" + [ARGV[0] , method].join('-').gsub(/[^0-9a-z ]/i, '') + ".txt"
if File.exists?(filename)
  puts File.read(filename)
else
  lines = ["> ### Example"]
  lines << "#{method} https://api.smartcitizen.me/v0/#{ARGV[0]}"
  lines << ""
  lines << "```shell"
  lines << `http #{method} 'https://api.smartcitizen.me/v0/#{ARGV[0]}' -p h`.split("\n")[0]
  result = JSON.parse(`http #{method} 'https://api.smartcitizen.me/v0/#{ARGV[0]}#{ARGV[0].include?('?') ? '&' : '?'}pretty=true'`)
  if result.kind_of?(Array)
    lines << "["
    lines << JSON.pretty_generate( result[0] )
    lines << "..."
  else
    lines << JSON.pretty_generate( result )
  end
  lines << "```"
  puts lines.join("\n")
  File.open( filename, 'w') { |file| file.puts lines.join("\n") }
end
