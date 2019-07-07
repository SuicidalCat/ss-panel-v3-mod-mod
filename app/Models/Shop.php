<?php

namespace App\Models;

use App\Services\Config;

class Shop extends Model
{
    protected $connection = 'default';
    protected $table = 'shop';

    public function content()
    {
        $content = json_decode($this->attributes['content'], true);
        $content_text = '';
        $i = 0;
        foreach ($content as $key => $value) {
            switch ($key) {
                case 'bandwidth':
                    $content_text .= '添加傳輸量 ' . $value . ' G ';
                    break;
                case 'expire':
                    $content_text .= ', 添加賬戶有效期 ' . $value . ' 天 ';
                    break;
                case 'class':
                    $content_text .= ', 為賬戶升級介入權限 ' . $value . ' , 有效期 ' . $content['class_expire'] . ' 天 ';
                    break;
                case 'reset':
                    $content_text .= ', 在 ' . $content['reset_exp'] . ' 天内 ，每 ' . $value . ' 天重置傳輸量為 ' . $content['reset_value'] . ' G ';
                    break;
                case 'speedlimit':
                    if ($value == 0) {
                        $content_text .= ', 接入速率不限制 ';
                    } else {
                        $content_text .= ', 接入速率更改為' . $value . ' Mbps ';
                    }
                    break;
                case 'connector':
                    if ($value == 0) {
                        $content_text .= ', 鏈接設備數量不限制';
                    } else {
                        $content_text .= ', 鏈接設備數量更改為 ' . $value . ' 個';
                    }
                    break;
                default:
            }
        }

        $content_text = rtrim($content_text, ',');

        return $content_text;
    }

    public function bandwidth()
    {
        $content = json_decode($this->attributes['content']);
        return $content->bandwidth ?? 0;
    }

    public function expire()
    {
        $content = json_decode($this->attributes['content']);
        return $content->expire ?? 0;
    }

    public function reset()
    {
        $content = json_decode($this->attributes['content']);
        return $content->reset ?? 0;
    }

    public function reset_value()
    {
        $content = json_decode($this->attributes['content']);
        return $content->reset_value ?? 0;
    }

    public function reset_exp()
    {
        $content = json_decode($this->attributes['content']);
        return $content->reset_exp ?? 0;
    }

    public function content_extra()
    {
        $content = json_decode($this->attributes['content']);
        if (isset($content->content_extra)) {
            $content_extra = $content->content_extra;
            $content_extra = explode(';', $content_extra);
            $content_extra_new = array();
            foreach ($content_extra as $innerContent) {
                if (false === strpos($innerContent, '-')) {
                    $innerContent = 'check-' . $innerContent;
                }
                $innerContent = explode('-', $innerContent);
                $content_extra_new[] = $innerContent;
            }
            $content_extra = $content_extra_new;
            return $content_extra;
        }

        return 0;
    }

    public function user_class()
    {
        $content = json_decode($this->attributes['content']);
        return $content->class ?? 0;
    }

    public function class_expire()
    {
        $content = json_decode($this->attributes['content']);
        return $content->class_expire ?? 0;
    }

    public function speedlimit()
    {
        $content = json_decode($this->attributes['content']);
        return $content->speedlimit ?? 0;
    }

    public function connector()
    {
        $content = json_decode($this->attributes['content']);
        return $content->connector ?? 0;
    }

    public function buy($user, $is_renew = 0)
    {
        $content = json_decode($this->attributes['content'], true);
        $content_text = '';

        foreach ($content as $key => $value) {
            switch ($key) {
                case 'bandwidth':
                    if ($is_renew == 0) {
                        if (Config::get('enable_bought_reset') == 'true') {
                            $user->transfer_enable = $value * 1024 * 1024 * 1024;
                            $user->u = 0;
                            $user->d = 0;
                            $user->last_day_t = 0;
                        } else {
                            $user->transfer_enable += $value * 1024 * 1024 * 1024;
                        }
                    } elseif ($this->attributes['auto_reset_bandwidth'] == 1) {
                        $user->transfer_enable = $value * 1024 * 1024 * 1024;
                        $user->u = 0;
                        $user->d = 0;
                        $user->last_day_t = 0;
                    } else {
                        $user->transfer_enable += $value * 1024 * 1024 * 1024;
                    }
                    break;
                case 'expire':
                    if (time() > strtotime($user->expire_in)) {
                        $user->expire_in = date('Y-m-d H:i:s', time() + $value * 86400);
                    } else {
                        $user->expire_in = date('Y-m-d H:i:s', strtotime($user->expire_in) + $value * 86400);
                    }
                    break;
                case 'class':
                    if (Config::get('enable_bought_extend') == 'true') {
                        if ($user->class == $value) {
                            $user->class_expire = date('Y-m-d H:i:s', strtotime($user->class_expire) + $content['class_expire'] * 86400);
                        } else {
                            $user->class_expire = date('Y-m-d H:i:s', time() + $content['class_expire'] * 86400);
                        }
                        $user->class = $value;
                    } else {
                        $user->class = $value;
                        $user->class_expire = date('Y-m-d H:i:s', time() + $content['class_expire'] * 86400);
                        break;
                    }
                case 'speedlimit':
                    $user->node_speedlimit = $value;
                    break;
                case 'connector':
                    $user->node_connector = $value;
                    break;
                default:
            }
        }

        $user->save();
    }
}
