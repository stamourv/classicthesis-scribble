(module reader syntax/module-reader
  #:read at-read
  #:read-syntax at-read-syntax
  #:whole-body-readers? #t
  #:language 'classicthesis/include

  (require (only-in scribble/reader
                    [read-inside at-read]
                    [read-syntax-inside at-read-syntax])))
