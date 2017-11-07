require 'erb'

x= $*[0]

struct = x.scan(/struct\s+?(\w+)/).flatten[0]
if !struct
  print "Check Input!!!\n"
  exit
end

a = []
x.each_line {|s|
  ta = s.strip.match(/var\s+?(\w+)[ =:]+([0-9.<>,? :\[\][:word:]]+).*/).to_a
  next if ta.count != 3
  a << [ta[1].strip, ta[2].strip]
}
if a.empty?
  exit
end

erb=<<M
enum <%= struct%>Item {
    <%- a.each do |ta| -%>
    case <%= ta[0]%>(<%= ta[1]%>)
    <%- end -%>
}
M

enumDecl = ERB.new(erb, nil, '-').result

enum = enumDecl.scan(/enum (.*?) {/)[0][0]
a = enumDecl.scan /case (.*?)\((.*?)\)\n/

l = 0
a.each {|x|
  l = [l, x[0].length].max
}

erb=<<M
// start of codegen 
<%= enumDecl -%>
extension <%= struct%> {
    init(_ enums: [<%= enum%>]) {
        for x in enums {
            switch x {
            <%- a.each do |ta|; t=ta[0].length -%>
                case .<%= ta[0]%>(let e): <%= (l-t).times.map{" "}.join("")%><%= ta[0]%> = e
            <%- end -%>
            } 
        }
    }
}
// end of codegen
M

print ERB.new(erb, nil, '-').result

