<?php

namespace App\Utils;

use App\Models\User;
use App\Services\Config;

class TelegramProcess
{
    private static function needbind_method($bot, $message, $command, $user, $reply_to = null)
    {
        if ($user != null) {
            switch ($command) {
                case 'traffic':
                    $bot->sendMessage($message->getChat()->getId(), "您當前傳輸量使用情況：
本日已用 ".$user->TodayusedTraffic()." ".number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100, 2)."%
總計已用 ".$user->LastusedTraffic()." ".number_format($user->last_day_t/$user->transfer_enable*100, 2)."%
剩餘 ".$user->unusedTraffic()." ".number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100, 2)."%
					                        ", $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                    break;
                case 'checkin':
                    if (!$user->isAbleToCheckin()) {
                        $bot->sendMessage($message->getChat()->getId(), "您已經簽到，請勿重複簽到！", $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                        break;
                    }
                    $traffic = rand(Config::get('checkinMin'), Config::get('checkinMax'));
                    $user->transfer_enable = $user->transfer_enable + Tools::toMB($traffic);
                    $user->last_check_in_time = time();
                    $user->save();
                    $bot->sendMessage($message->getChat()->getId(), "簽到成功，您獲得了 ".$traffic." MB 傳輸量！", $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                    break;
	    	case 'prpr':
		    $prpr = array('⁄(⁄ ⁄•⁄ω⁄•⁄ ⁄)⁄', '(≧ ﹏ ≦)', '(*/ω＼*)', 'ヽ(*。>Д<)o゜', '(つ ﹏ ⊂)', '( >  < )');
                    $bot->sendMessage($message->getChat()->getId(), $prpr[mt_rand(0,5)], $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
                    break;
                default:
                    $bot->sendMessage($message->getChat()->getId(), "???", $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
            }
        } else {
            $bot->sendMessage($message->getChat()->getId(), "您尚未綁定WallLink賬戶。", $parseMode = null, $disablePreview = false, $replyToMessageId = $reply_to);
        }
    }


    public static function telegram_process($bot, $message, $command)
    {
        $user = User::where('telegram_id', $message->getFrom()->getId())->first();

        if ($message->getChat()->getId() > 0) {
            //个人
            $commands = array("ping", "chat", "traffic", "checkin", "help");
            if(in_array($command, $commands)){
                $bot->sendChatAction($message->getChat()->getId(), 'typing');
            }
            switch ($command) {
                case 'ping':
                    $bot->sendMessage($message->getChat()->getId(), 'Pong!这个群组的 ID 是 '.$message->getChat()->getId().'!');
                    break;
                case 'chat':
                    $bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), substr($message->getText(), 5)));
                    break;
                case 'traffic':
                    TelegramProcess::needbind_method($bot, $message, $command, $user);
                    break;
                case 'checkin':
                    TelegramProcess::needbind_method($bot, $message, $command, $user, $message->getMessageId());
                    break;
	    	case 'prpr':
                    TelegramProcess::needbind_method($bot, $message, $command, $user, $message->getMessageId());
                    break;
                case 'help':
                    $help_list = "指令列表：
						/traffic 查詢傳輸量使用情況
						/checkin 進行賬戶簽到
						/help 獲取使用幫助

						您可以在用戶面板中的“資料編輯” 獲取綁定設置。
					          ";
                    $bot->sendMessage($message->getChat()->getId(), $help_list);
                    break;
                default:
                    if ($message->getPhoto() != null) {
                        $bot->sendMessage($message->getChat()->getId(), "正在嘗試讀取二維碼...");
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

                            if ($photo_size_array[$real_id] < $file->getFileSize()) {
                                $photo_size_array[$real_id] = $file->getFileSize();
                                $photo_id_array[$real_id] = $file->getFileId();
                                if (!isset($photo_id_list_array[$real_id])) {
                                    $photo_id_list_array[$real_id] = array();
                                }

                                array_push($photo_id_list_array[$real_id], $file->getFileId());
                            }
                        }

                        foreach ($photo_id_array as $key => $value) {
                            $file = $bot->getFile($value);
                            $qrcode_text = QRcode::decode("https://api.telegram.org/file/bot".Config::get('telegram_token')."/".$file->getFilePath());

                            if ($qrcode_text == null) {
                                foreach ($photo_id_list_array[$key] as $fail_key => $fail_value) {
                                    $fail_file = $bot->getFile($fail_value);
                                    $qrcode_text = QRcode::decode("https://api.telegram.org/file/bot".Config::get('telegram_token')."/".$fail_file->getFilePath());
                                    if ($qrcode_text != null) {
                                        break;
                                    }
                                }
                            }

                            if (substr($qrcode_text, 0, 11) == 'mod://bind/' && strlen($qrcode_text) == 27) {
                                $uid = TelegramSessionManager::verify_bind_session(substr($qrcode_text, 11));
                                if ($uid != 0) {
                                    $user = User::where('id', $uid)->first();
                                    $user->telegram_id = $message->getFrom()->getId();
                                    $user->im_type = 4;
                                    $user->im_value = $message->getFrom()->getUsername();
                                    $user->save();
                                    $bot->sendMessage($message->getChat()->getId(), "您已經成功綁定。電子郵箱：".$user->email);
                                } else {
                                    $bot->sendMessage($message->getChat()->getId(), "綁定出現了錯誤，您提供的QR Code無效。".substr($qrcode_text, 11));
                                }
                            }

                            if (substr($qrcode_text, 0, 12) == 'mod://login/' && strlen($qrcode_text) == 28) {
                                if ($user != null) {
                                    $uid = TelegramSessionManager::verify_login_session(substr($qrcode_text, 12), $user->id);
                                    if ($uid != 0) {
                                        $bot->sendMessage($message->getChat()->getId(), "您已經成功驗證登錄。電子郵箱：".$user->email);
                                    } else {
                                        $bot->sendMessage($message->getChat()->getId(), "驗證登錄的過程出現錯誤，您提供的QR Code無效。".substr($qrcode_text, 12));
                                    }
                                } else {
                                    $bot->sendMessage($message->getChat()->getId(), "驗證登錄的過程出現錯誤，您尚未綁定WallLink賬戶。".substr($qrcode_text, 12));
                                }
                            }

                            break;
                        }
                    } else {
                        if (is_numeric($message->getText()) && strlen($message->getText()) == 6) {
                            if ($user != null) {
                                $uid = TelegramSessionManager::verify_login_number($message->getText(), $user->id);
                                if ($uid != 0) {
                                    $bot->sendMessage($message->getChat()->getId(), "您已經成功驗證登錄。電子郵箱：".$user->email);
                                } else {
                                    $bot->sendMessage($message->getChat()->getId(), "驗證登錄的過程出現錯誤，您提供的驗證代碼無效。");
                                }
                            } else {
                                $bot->sendMessage($message->getChat()->getId(), "驗證登錄的過程出現錯誤，您尚未綁定WallLink賬戶。");
                            }
                            break;
                        }
                        $bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), $message->getText()));
                    }
            }
        } else {
            //群组
            if (Config::get('telegram_group_quiet') == 'true') {
                return;
            }
            $commands = array("ping", "chat", "traffic", "checkin", "help");
            if(in_array($command, $commands)){
                $bot->sendChatAction($message->getChat()->getId(), 'typing');
            }
            switch ($command) {
                case 'ping':
                    $bot->sendMessage($message->getChat()->getId(), 'Pong!这个群组的 ID 是 '.$message->getChat()->getId().'!', $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    break;
                case 'chat':
                    if ($message->getChat()->getId() == Config::get('telegram_chatid')) {
                        $bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), substr($message->getText(), 5)), $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    } else {
                        $bot->sendMessage($message->getChat()->getId(), '我只是一個沒有感情的機器人。', $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    }
                    break;
                case 'traffic':
                    TelegramProcess::needbind_method($bot, $message, $command, $user, $message->getMessageId());
                    break;
                case 'checkin':
                    TelegramProcess::needbind_method($bot, $message, $command, $user, $message->getMessageId());
                    break;
	    	case 'prpr':
                    TelegramProcess::needbind_method($bot, $message, $command, $user, $message->getMessageId());
                    break;
                case 'help':
                    $help_list_group = "指令列表：
						/traffic 查詢傳輸量使用情況
						/checkin 進行賬戶簽到
						/help 獲取使用幫助

						您可以在用戶面板中的“資料編輯” 獲取綁定設置。
					";
                    $bot->sendMessage($message->getChat()->getId(), $help_list_group, $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                    break;
                default:
                    if ($message->getText() != null) {
                        if ($message->getChat()->getId() == Config::get('telegram_chatid')) {
                            $bot->sendMessage($message->getChat()->getId(), Tuling::chat($message->getFrom()->getId(), $message->getText()), $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                        } else {
                            $bot->sendMessage($message->getChat()->getId(), '我只是一個沒有感情的機器人。', $parseMode = null, $disablePreview = false, $replyToMessageId = $message->getMessageId());
                        }
                    }
                    if ($message->getNewChatMember() != null && Config::get('enable_welcome_message') == 'true') {
                        $bot->sendMessage($message->getChat()->getId(), "欢迎 ".$message->getNewChatMember()->getFirstName()." ".$message->getNewChatMember()->getLastName(), $parseMode = null, $disablePreview = false);
                    }
            }
        }

        $bot->sendChatAction($message->getChat()->getId(), '');
    }

    public static function process()
    {
        try {
            $bot = new \TelegramBot\Api\Client(Config::get('telegram_token'));
            // or initialize with botan.io tracker api key
            // $bot = new \TelegramBot\Api\Client('YOUR_BOT_API_TOKEN', 'YOUR_BOTAN_TRACKER_API_KEY');

            $command_list = array("ping", "chat" ,"traffic", "help", "prpr", "checkin");
            foreach ($command_list as $command) {
                $bot->command($command, function ($message) use ($bot, $command) {
                    TelegramProcess::telegram_process($bot, $message, $command);
                });
            }

            $bot->on($bot->getEvent(function ($message) use ($bot) {
                TelegramProcess::telegram_process($bot, $message, '');
            }), function () {
                return true;
            });

            $bot->run();
        } catch (\TelegramBot\Api\Exception $e) {
            $e->getMessage();
        }
    }
}
