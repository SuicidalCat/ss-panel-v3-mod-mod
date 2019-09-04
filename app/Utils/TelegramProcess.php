<?php

namespace App\Utils;

use App\Models\User;
use App\Services\Config;
use App\Controllers\LinkController;
use TelegramBot\Api\Client;
use TelegramBot\Api\Exception;
use TelegramBot\Api\Types\Inline\InlineKeyboardMarkup;

class TelegramProcess
{
    private static $all_rss = [
        'clean_link' => '重置訂閲鏈接',
        '?mu=0' => 'SSR多端口訂閲',
        '?mu=1' => 'SSR單端口訂閲',
        '?mu=3' => 'SS/SSD訂閲',
        '?mu=2' => 'V2ray訂閲',
        '?mu=4' => 'Clash訂閲'];

    private static function callback_bind_method($bot, $callback)
    {
        $callback_data = $callback->getData();
        $message = $callback->getMessage();
        $reply_to = $message->getMessageId();
        $user = User::where('telegram_id', $callback->getFrom()->getId())->first();
        $reply_message = '？？？';
        if ($user != null) {
            switch (true) {
                case (strpos($callback_data, 'mu')):
                    $ssr_sub_token = LinkController::GenerateSSRSubCode($user->id, 0);
                    $subUrl = Config::get('subUrl');
                    $reply_message = self::$all_rss[$callback_data] . ': ' . $subUrl . $ssr_sub_token . $callback_data . PHP_EOL;
                    break;
                case ($callback_data == 'clean_link'):
                    $user->clean_link();
                    $reply_message = '訂閲鏈接已被成功重置';
                    break;
            }
            $bot->sendMessage($message->getChat()->getId(), $reply_message, $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
        }
    }

    private static function needbind_method($bot, $message, $command, $user, $reply_to = null)
    {
        $reply = [
            'message' => '咩咩咩？',
            'markup' => null,
        ];
        if ($user != null) {
            switch ($command) {
                case 'traffic':
                    $reply['message'] = '您當前傳輸量使用情況：
本日已用 ' . $user->TodayusedTraffic() . ' ' . number_format(($user->u + $user->d - $user->last_day_t) / $user->transfer_enable * 100, 2) . '%
總計已用 ' . $user->LastusedTraffic() . ' ' . number_format($user->last_day_t / $user->transfer_enable * 100, 2) . '%
剩餘 ' . $user->unusedTraffic() . ' ' . number_format(($user->transfer_enable - ($user->u + $user->d)) / $user->transfer_enable * 100, 2) . '%';
                    break;
                case 'checkin':
                    if (!$user->isAbleToCheckin()) {
                        $reply['message'] = '您已經簽到，請勿重複簽到！';
                        break;
                    }
                    $traffic = random_int(Config::get('checkinMin'), Config::get('checkinMax'));
                    $user->transfer_enable += Tools::toMB($traffic);
                    $user->last_check_in_time = time();
                    $user->save();
                    $reply['message'] = '簽到成功，您獲得了 ' . $traffic . ' MB 傳輸量！';
                    break;
                case 'prpr':
                    $prpr = array('⁄(⁄ ⁄•⁄ω⁄•⁄ ⁄)⁄', '(≧ ﹏ ≦)', '(*/ω＼*)', 'ヽ(*。>Д<)o゜', '(つ ﹏ ⊂)', '( >  < )');
                    $reply['message'] = $prpr[random_int(0, 5)];
                    break;
                case 'rss':
                    $reply['message'] = '點擊以下按鈕獲取訂閲鏈接 ';
                    $keys = [];
                    foreach (self::$all_rss as $key => $value) {
                        $keys[] = [['text' => $value, 'callback_data' => $key]];
                    }
                    $reply['markup'] = new InlineKeyboardMarkup(
                        $keys
                    );
                    break;
            }
        } else {
            $reply['message'] = '您尚未綁定WallLink賬戶，您可以在用戶面板中的“資料編輯” 處獲取綁定設置。';
        }

        return $reply;
    }


    public static function telegram_process($bot, $message, $command)
    {
        $user = User::where('telegram_id', $message->getFrom()->getId())->first();
        $reply_to = $message->getMessageId();
        $reply = [
            'message' => '？？？',
            'markup' => null,
        ];
        if ($message->getChat()->getId() > 0) {
            //个人
            $bot->sendChatAction($message->getChat()->getId(), 'typing');

            switch ($command) {
                case 'ping':
                    $reply['message'] = 'Pong!您的 ID 是 ' . $message->getChat()->getId() . '!';
                    break;
                case 'traffic':
                case 'checkin':
                case 'prpr':
                case 'rss':
                    $reply = self::needbind_method($bot, $message, $command, $user, $reply_to);
                    break;
                case 'help':
                    $reply['message'] = 'Bot指令列表：
						/traffic 查詢傳輸量使用情況
						/checkin 進行賬戶簽到
						/help 獲取使用幫助
						/rss 獲取接入點訂閲';
                    if ($user == null) {
                        $help_list .= PHP_EOL . '您尚未綁定WallLink賬戶，您可以在用戶面板中的“資料編輯” 處獲取綁定設置。';
                    }
                    break;
                default:
                    if ($message->getPhoto() == null) {
                        if (!is_numeric($message->getText()) || strlen($message->getText()) != 6) {
                            $reply['message'] = Tuling::chat($message->getFrom()->getId(), $message->getText());
                            break;
                        }

                        if ($user != null) {
                            $uid = TelegramSessionManager::verify_login_number($message->getText(), $user->id);
                            if ($uid != 0) {
                                $reply['message'] = '您已經成功驗證登錄。電子郵箱：' . $user->email;
                            } else {
                                $reply['message'] = '驗證登錄的過程出現錯誤，您提供的驗證代碼無效。';
                            }
                            break;
                        }

                        $reply['message'] = '驗證登錄的過程出現錯誤，您尚未綁定WallLink賬戶。';
                        break;
                    }

                    $bot->sendMessage($message->getChat()->getId(), '正在嘗試讀取QR Code...');
                    $bot->sendChatAction($message->getChat()->getId(), 'typing');
                    $photos = $message->getPhoto();

                    $photo_size_array = array();
                    $photo_id_array = array();
                    $photo_id_list_array = array();

                    foreach ($photos as $photo) {
                        $file = $bot->getFile($photo->getFileId());
                        $real_id = substr($file->getFileId(), 0, 36);
                        if (!isset($photo_size_array[$real_id])) {
                            $photo_size_array[$real_id] = 0;
                        }

                        if ($photo_size_array[$real_id] >= $file->getFileSize()) {
                            continue;
                        }

                        $photo_size_array[$real_id] = $file->getFileSize();
                        $photo_id_array[$real_id] = $file->getFileId();
                        if (!isset($photo_id_list_array[$real_id])) {
                            $photo_id_list_array[$real_id] = array();
                        }

                        $photo_id_list_array[$real_id][] = $file->getFileId();
                    }

                    foreach ($photo_id_array as $key => $value) {
                        $file = $bot->getFile($value);
                        $qrcode_text = QRcode::decode('https://api.telegram.org/file/bot' . Config::get('telegram_token') . '/' . $file->getFilePath());

                        if ($qrcode_text == null) {
                            foreach ($photo_id_list_array[$key] as $fail_key => $fail_value) {
                                $fail_file = $bot->getFile($fail_value);
                                $qrcode_text = QRcode::decode('https://api.telegram.org/file/bot' . Config::get('telegram_token') . '/' . $fail_file->getFilePath());
                                if ($qrcode_text != null) {
                                    break;
                                }
                            }
                        }

                        if (strpos($qrcode_text, 'mod://bind/') === 0 && strlen($qrcode_text) == 27) {
                            $uid = TelegramSessionManager::verify_bind_session(substr($qrcode_text, 11));
                            if ($uid == 0) {
                                $reply['message'] = '綁定出現了錯誤，您提供的QR Code無效：' . substr($qrcode_text, 11) . 'QR Code有效期為10分鐘，請嘗試刷新用戶面板的“資料編輯”頁面以更新QR Code';
                                continue;
                            }
                            $user = User::where('id', $uid)->first();
                            $user->telegram_id = $message->getFrom()->getId();
                            $user->im_type = 4;
                            $user->im_value = $message->getFrom()->getUsername();
                            $user->save();
                            $reply['message'] = '您已經成功綁定。電子郵箱：' . $user->email;
                            break;
                        }

                        if (strpos($qrcode_text, 'mod://login/') === 0 && strlen($qrcode_text) == 28) {
                            if ($user == null) {
                                $reply['message'] = '驗證登錄的過程出現錯誤，您尚未綁定WallLink賬戶。' . substr($qrcode_text, 12);
                                break;
                            }

                            $uid = TelegramSessionManager::verify_login_session(substr($qrcode_text, 12), $user->id);
                            if ($uid != 0) {
                                $reply['message'] = '您已經成功驗證登錄。電子郵箱：' . $user->email;
                            } else {
                                $reply['message'] = '驗證登錄的過程出現錯誤，您提供的QR Code無效。' . substr($qrcode_text, 12);
                            }
                            break;
                        }

                        break;
                    }
            }
        } else {
            //群组
            if (Config::get('telegram_group_quiet') == 'true') {
                return;
            }
            $bot->sendChatAction($message->getChat()->getId(), 'typing');

            switch ($command) {
                case 'ping':
                    $reply['message'] = 'Pong!这个群组的 ID 是 ' . $message->getChat()->getId() . '!';
                    break;
                case 'traffic':
                case 'checkin':
                case 'prpr':
                    $reply = self::needbind_method($bot, $message, $command, $user, $reply_to);
                    break;
                case 'rss':
                    $reply['message'] = '请私聊机器人使用该命令';
                    break;
                case 'help':
                    $reply['message'] = 'Bot指令列表：
                    /traffic 查詢傳輸量使用情況
                    /checkin 進行賬戶簽到
                    /help 獲取使用幫助
                    /rss 獲取接入點訂閲';
                    if ($user == null) {
                        $reply['message'] .= PHP_EOL . '您尚未綁定WallLink賬戶，您可以在用戶面板中的“資料編輯” 處獲取綁定設置。';
                    }
                    break;
                default:
                    if ($message->getText() != null) {
                        if ($message->getChat()->getId() == Config::get('telegram_chatid')) {
                            $reply['message'] = Tuling::chat($message->getFrom()->getId(), $message->getText());
                        } else {
                            $reply['message'] = '我只是一個沒有感情的Bot。';
                        }
                    }
                    if ($message->getNewChatMember() != null && Config::get('enable_welcome_message') == 'true') {
                        $reply['message'] = '歡迎 ' . $message->getNewChatMember()->getFirstName() . ' ' . $message->getNewChatMember()->getLastName();
                    } else {
                        $reply['message'] = null;
                    }
            }
        }

        $bot->sendMessage($message->getChat()->getId(), $reply['message'], $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to, $replyMarkup = $reply['markup']);
        $bot->sendChatAction($message->getChat()->getId(), '');
    }

    public static function process()
    {
        try {
            $bot = new Client(Config::get('telegram_token'));
            // or initialize with botan.io tracker api key
            // $bot = new \TelegramBot\Api\Client('YOUR_BOT_API_TOKEN', 'YOUR_BOTAN_TRACKER_API_KEY');

            $command_list = array('ping', 'traffic', 'help', 'prpr', 'checkin', 'rss');
            foreach ($command_list as $command) {
                $bot->command($command, static function ($message) use ($bot, $command) {
                    TelegramProcess::telegram_process($bot, $message, $command);
                });
            }

            $bot->on($bot->getEvent(static function ($message) use ($bot) {
                TelegramProcess::telegram_process($bot, $message, '');
            }), static function () {
                return true;
            });

            $bot->on($bot->getCallbackQueryEvent(function ($callback) use ($bot) {
                TelegramProcess::callback_bind_method($bot, $callback);
            }), function () {
                return true;
            });

            $bot->run();
        } catch (Exception $e) {
            $e->getMessage();
        }
    }
}
