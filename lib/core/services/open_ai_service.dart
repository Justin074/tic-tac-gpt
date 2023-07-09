import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:tic_tac_gpt/core/models/game_board.dart';

class OpenAiService {
  static Future<String> getChatAnswer(GameBoard board) async {
    final OpenAI instance = OpenAI.instance.build(
      token: 'Your Token Here',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true,
    );

    final ChatCompleteText request = ChatCompleteText(messages: [
      Messages(role: Role.user, content: "Lets play a game of TicTacToe, it is currently your move as the character O, the current board setup is as follows: #[${board.mapToGPT}]# Please return your answer in the following format: #NewBoard#")
    ], maxToken: 200, model: GptTurbo0301ChatModel());

    final ChatCTResponse? response = await instance.onChatCompletion(
      request: request,
    );

    if (response == null) return '';
    return response.choices.first.message?.content ?? '';
  }
}
