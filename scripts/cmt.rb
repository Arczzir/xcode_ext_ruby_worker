
path = "/Users/z/Downloads/xxx"
x = $*[0]
File.open(path, 'w') {|f|
    f << x
}
print `/Users/z/Downloads/commentExt #{path}`
