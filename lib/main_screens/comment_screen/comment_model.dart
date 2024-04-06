class CommentModel {
  final String image, name, comment, reply, like, time;
  final bool isShowReply;

  CommentModel({
    required this.image,
    required this.name,
    required this.comment,
    required this.reply,
    required this.like,
    required this.time,
    required this.isShowReply,
  });
}

List<CommentModel> myAllCommentData() {
  CommentModel commentModel = CommentModel(
    image: "assets/images/person1.jpg",
    name: "Martin Carder",
    comment:
        "\"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama \"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama \"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama \"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama ",
    reply: "2",
    like: "12",
    time: "15m",
    isShowReply: true,
  );
  CommentModel commentModel1 = CommentModel(
    image: "assets/images/person1.jpg",
    name: "Martin Carder",
    comment:
        "\"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama \"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama ",
    reply: "26",
    like: "176",
    time: "18m",
    isShowReply: true,
  );
  CommentModel commentModel2 = CommentModel(
    image: "assets/images/person1.jpg",
    name: "Martin Carder",
    reply: "34",
    like: "120",
    isShowReply: false,
    time: "1m",
    comment:
        "\"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama Dalai Lama ",
  );
  CommentModel commentModel3 = CommentModel(
    image: "assets/images/person1.jpg",
    name: "Martin Carder",
    reply: "76",
    like: "423",
    time: "2m",
    comment:
        "\"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama \"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama ",
    isShowReply: true,
  );
  CommentModel commentModel4 = CommentModel(
    image: "assets/images/person1.jpg",
    name: "Martin Carder",
    reply: "2",
    like: "12",
    time: "12m",
    isShowReply: true,
    comment:
        "\"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama ",
  );

  CommentModel commentModel5 = CommentModel(
    image: "assets/images/person1.jpg",
    name: "Martin Carder",
    reply: "2",
    like: "12",
    time: "12m",
    isShowReply: true,
    comment:
        "\"If you think you are to small to make a difference, try sleeping with a mosquito\" Dalai Lama ",
  );
  return [
    commentModel,
    commentModel1,
    commentModel2,
    commentModel3,
    commentModel4,
    commentModel5,
  ];
}

List<CommentModel> myAllCommentDetailData() {
  CommentModel commentModel = CommentModel(
    image: "assets/images/person1.jpg",
    name: "Martin Carder",
    comment: "Hello",
    reply: "2",
    like: "12",
    time: "15m",
    isShowReply: true,
  );
  CommentModel commentModel1 = CommentModel(
    image: "assets/images/person1.jpg",
    name: "Martin Carder",
    comment: "Hi",
    reply: "26",
    like: "176",
    time: "18m",
    isShowReply: true,
  );
  CommentModel commentModel2 = CommentModel(
      image: "assets/images/person1.jpg",
      name: "Martin Carder",
      comment: "Hi bye bye",
      reply: "26",
      like: "176",
      time: "18m",
      isShowReply: false);
  CommentModel commentModel3 = CommentModel(
    image: "assets/images/person1.jpg",
    name: "Martin Carder",
    comment: "Hi",
    reply: "26",
    like: "176",
    time: "18m",
    isShowReply: true,
  );

  return [
    commentModel,
    commentModel1,
    commentModel2,
    commentModel3,
  ];
}
