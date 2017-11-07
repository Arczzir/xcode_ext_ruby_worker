require 'erb'

x = $*[0]

name = x

erb=<<M.strip
class #{x}ViewData: DAViewData {
    
}

class #{x}View: DAView<#{x}ViewData> {
    
}

class #{x}: DAControl<#{x}ViewData, #{x}View> {
    
}
M

print ERB.new(erb, nil, '-').result(binding)


