class StickerModel {
  final String id;
  final String imgPath;

  StickerModel({required this.id, required this.imgPath});

  @override
  bool operator ==(Object other) {
    return (other as StickerModel).id == id;
  }


  //Set에서 중복 여부를 결정하는 속성
  //ID 값이 같으면 Set 안에서 같은 인스턴스로 인식
  int get hasCode => id.hashCode;
}
