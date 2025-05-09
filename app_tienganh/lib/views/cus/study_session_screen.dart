import 'package:flutter/material.dart';
import 'package:app_tienganh/core/app_colors.dart';
import '../../widgets/navbar.dart';
import '../../widgets/list_card.dart';
import '../../widgets/avatarname.dart';
import '../../widgets/function_card.dart';
import '../../widgets/setting_study_section.dart';
import '../../widgets/voca.dart';

class StudySessionPage extends StatefulWidget {
  final Function(int) onNavigate;
  final int? userId;
  final int? hocphanId;

  const StudySessionPage({
    super.key,
    required this.onNavigate,
    this.userId,
    this.hocphanId,
  });

  @override
  State<StudySessionPage> createState() => _StudySessionPageState();
}

class _StudySessionPageState extends State<StudySessionPage> {
  final String title = 'Từ vựng TOEIC B1';
  final String username = 'username_demo'; // Sẽ lấy từ DB dựa trên userId
  final int wordCount = 20;

  final List<String> vocabulary = ['confuse', 'efficient', 'require', 'attend'];


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomNavBar(
        title: "Học phần của bạn",
        leadingIconPath: "assets/img/back.svg",
        onLeadingPressed: () {
          widget.onNavigate(1);
        },
      ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 34, 0, 0),
          child: Column(
            children: [
              ListCard(
                vocabularyList: vocabulary
                    .map((word) => {
                          'word': word,
                          'meaning': 'Nghĩa của $word',
                        })
                    .toList(),
              ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.highlightDarkest,
                              fontFamily: 'Montserrat',
                            ),
                          ),

                          // const SizedBox(width: 151),
                          const Spacer(),

                          GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              final RenderBox overlay =
                                  Overlay.of(context).context.findRenderObject()
                                      as RenderBox;
                              showMenu<String>(
                                context: context,
                                position: RelativeRect.fromRect(
                                  details.globalPosition & Size(40, 40),
                                  Offset.zero & overlay.size,
                                ),
                                menuPadding: EdgeInsets.all(0),
                                items: [
                                  PopupMenuItem<String>(
                                    value: 'Custom Widget', // Custom item
                                    child: Material(
                                      color: Colors.transparent,
                                      child: SettingStudySection(
                                        onSelected: (title) {
                                          if (title == "Sửa học phần") {
                                            // xử lý sửa học phần
                                            widget.onNavigate(23);
                                          } else if (title == "Xóa học phần") {
                                            // xử lý xóa học phần
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                                color: Colors.white,
                              );
                            },
                            child: const Icon(
                              Icons.more_horiz,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 17.5),

                      Row(
                        children: [
                          AvatarName(
                            username: username,
                            profileImage: "assets/img/user.jpg",
                          ),

                          // const SizedBox(width: 95),
                          const Spacer(),

                          VerticalDivider(
                            thickness: 2,
                            width: 20,
                            color: Colors.blue,
                          ),

                          // const SizedBox(width: 190),
                          const Spacer(),

                          Text(
                            '$wordCount từ vựng',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 17),

                      const Text(
                        'Mô tả',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                      ),

                      const SizedBox(height: 12),

                      FunctionCard(
                        icon: Icons.edit_note,
                        text: 'Thẻ ghi nhớ',
                        onTap: () {
                          widget.onNavigate(16);
                        },
                      ),
                      FunctionCard(
                        icon: Icons.task_sharp,
                        text: 'Kiểm tra',
                        onTap: () {
                          widget.onNavigate(15);
                        },
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Từ vựng',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 8),

                      Column(
                        children:
                            vocabulary
                                .map(
                                  (word) => Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Voca(label: word),
                                  ),
                                )
                                .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
