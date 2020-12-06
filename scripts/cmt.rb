path = File.expand_path "~/Downloads/xxx"
x = $*[0]
File.open(path, 'w') {|f|
    f << x
}
print `~/Downloads/commentExt "#{path}"`
