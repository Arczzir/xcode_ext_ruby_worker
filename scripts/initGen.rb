require 'erb'

x= $*[0]



klass = x.scan(/(?:class|struct)\s+?(\w+)/).flatten[0]
if !klass
  print "Check Input!!!\n"
  exit
end

a = []
x.each_line {|s|
  ta = s.strip.match(/var\s+?(\w+)[ =:]+([0-9.<>,? :\[\][:word:]]+).*/).to_a
  next if ta.count != 3

  name = ta[1].strip
  type = ta[2].strip
  if type == "true" || type == "false"
    type = "Bool"
  end

  if /\A[-0-9e+A-Fa-fx]+\z/ === type
    type = "Int"
  elsif /\A[-0-9e+.]+\z/ === type
    type = "Double"
  end 
  
  a << [name, type]
}
if a.empty?
  print "Check Input!!!\n"
  exit
end

erb=<<M.strip
init(<%= a.map{|x|"%s: %s"%x}.join(", ") %>) {
    <%- a.each do |ta| -%>
    self.<%= ta[0]%> = <%= ta[0]%>
    <%- end -%>
}
M

print ERB.new(erb, nil, '-').result(binding)


