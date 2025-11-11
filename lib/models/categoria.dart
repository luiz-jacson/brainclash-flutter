class Categoria {
  
  String? _id; 
  String _nome;
  String? _colorHex;
  int? _iconCodePoint;
  String? _imageUrl;

  Categoria(
    this._nome,
    this._colorHex,
    this._iconCodePoint,
    this._imageUrl,
    [this._id] 
  );

  String get nome => _nome;
  String? get id => _id; 
  String? get colorHex => _colorHex;
  int? get iconCodePoint => _iconCodePoint;
  String? get imageUrl => _imageUrl;


  set nome(String nome) => _nome = nome;
  set id(String? id) => _id = id; 
  set colorHex(String? colorHex) => _colorHex = colorHex;
  set iconCodePoint(int? iconCodePoint) => _iconCodePoint = iconCodePoint;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;


  Map<String, dynamic> toMap() {
    return {
      "nome": _nome,
      "colorHex": _colorHex,
      "iconCodePoint": _iconCodePoint,
      "imageUrl": _imageUrl,
    };
  }


  factory Categoria.fromFirestore(String docId, Map<String, dynamic> map) {
    return Categoria(
      map["nome"] as String,
      map["colorHex"] as String?,
      map["iconCodePoint"] as int?,
      map["imageUrl"] as String?,
      docId, 
    );
  }
}