class ChatModel {
  String name;
  String message;
  String time;
  String avatarUrl ;

  ChatModel({required this.name, required this.message, required this.time, this.avatarUrl =  "https://www.pngkit.com/png/detail/28-284289_anonymous-clipart-female-woman-icon-black-and-white.png"});
}
  List<ChatModel> dumbData = [
    ChatModel(name: "Ariana", message: "Hi", time: "15:30", avatarUrl: "https://vnn-imgs-f.vgcloud.vn/2021/11/20/14/tinh-truong-cua-ariana-grande-truoc-khi-cuoi-doanh-nhan-bat-dong-san.jpg"),
    ChatModel(name: "Jungkook", message: "Hi", time: "15:30", avatarUrl:  "https://www.google.com/url?sa=i&url=https%3A%2F%2Fencrypted-tbn0.gstatic.com%2Fimages%3Fq%3Dtbn%3AANd9GcSB3TP5MlzEzYk9DvABQc8OUCM9LQSSYgiUv4OirbvRgKzmKouU&psig=AOvVaw3p_DiIZdigO-cdbY1Mwc27&ust=1652694150157000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCMi_-s-b4fcCFQAAAAAdAAAAABAD"),
    ChatModel(name: "Saoirse Ronan", message: "Hi", time: "15:30", avatarUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkQlLye2oSgvXx9LLT0dLgKT_jIqOENabkW8Zwh8LLAxZuY4IR"),
    ChatModel(name: "IU", message: "Hi", time: "15:30", avatarUrl: "https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/12/5/981148/IU-Anh-Doc.jpg"),
    ChatModel(name: "Jimin", message: "Hi", time: "15:31", avatarUrl: "https://kpopnews.atsit.in/vi/wp-content/uploads/2021/12/park-jimin-bat-kha-chien-bai-bts-jimin-vi-tri-thu-nhat-trong-cuoc-binh-chon-muc-do-noi-tieng-toan-cau-trong-77-tuan-ky-luc-moi-muc-do-noi-tieng-mot-nguoi-dung-dau.jpg"),
    ChatModel(name: "Suga", message: "Hi", time: "15:32", avatarUrl: "https://i.pinimg.com/originals/b1/fc/5f/b1fc5f8e764a987e5d671f176d0df8b2.jpg"),
    ChatModel(name: "RM", message: "Hi", time: "15:32", avatarUrl: "https://www.thewikifeed.com/wp-content/uploads/2021/05/rm-1.jpg"),
    ChatModel(name: "V", message: "Hi", time: "15:32", avatarUrl: "https://file.tinnhac.com/resize/600x-/2022/02/16/20220216083100-b877.jpg"),
    ChatModel(name: "Jin", message: "Hi", time: "15:32", avatarUrl: "https://lh3.googleusercontent.com/rsinNbEDPHC6RzCyBHdQJFgqWkkz0g_fb_iEqq2fcMad-orgGSZx_FjU65Q7m7IA6Wve_Hrts5IlGGlIuUzq75E"),
    ChatModel(name: "Jhope", message: "Hi", time: "15:33", avatarUrl: "https://cdnmedia.thethaovanhoa.vn/Upload/leenEplQKY7jsunvYUYgg/files/2021/02/dad1.jpg"),
    ChatModel(name: "Anonymous", message: "Hello", time: "15:33"),
  ];