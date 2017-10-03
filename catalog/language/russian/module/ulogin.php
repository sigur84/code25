<?php

$_ =  array(
	'heading_title' => 'Войти с помощью:',

	'ulogin_add_account_success' => 'Аккаунт успешно добавлен',
	'ulogin_db_error' => 'Ошибка при работе с БД.',

	'ulogin_verify' => 'Подтверждение аккаунта.',
	'ulogin_verify_text' => 'Электронный адрес данного аккаунта совпадает с электронным адресом существующего пользователя. <br>Требуется подтверждение на владение указанным email.',

	'ulogin_synch' => 'Синхронизация аккаунтов.',
	'ulogin_synch_text' => 'С данным аккаунтом уже связаны данные из другой социальной сети. <br>Требуется привязка новой учётной записи социальной сети к этому аккаунту.',

	'ulogin_reg_error' => 'Ошибка при регистрации.',
	'ulogin_reg_error_text' => 'Произошла ошибка при регистрации пользователя.',

	'ulogin_auth_error' => 'Произошла ошибка при авторизации.',
	'ulogin_add_account_error' => 'Не удалось записать данные об аккаунте.',
	'ulogin_no_token_error' => 'Не был получен токен uLogin.',
	'ulogin_no_user_data_error' => 'Не удалось получить данные о пользователе с помощью токена.',
	'ulogin_wrong_user_data_error' => 'Данные о пользователе содержат неверный формат.',
	'ulogin_host_address_error' => '<i>ERROR</i>: адрес хоста не совпадает с оригиналом %s',
	'ulogin_token_expired_error' => '<i>ERROR</i>: время жизни токена истекло',
	'ulogin_invalid_token_error' => '<i>ERROR</i>: неверный токен',
	'ulogin_no_variable_error' => 'В возвращаемых данных отсутствует переменная <b>%s</b>',

	'ulogin_account_not_available' => 'Данный аккаунт привязан к другому пользователю. </br>Вы не можете использовать этот аккаунт',

	'ulogin_delete_account_success' => 'Удаление аккаунта %s успешно выполнено',
	'ulogin_delete_account_error' => 'Ошибка при удалении аккаунта',

	'ulogin_back_url' => 'Вернуться',

	'ulogin_account_inactive' => 'Аккаунт создан. Тем не менее, требуется активация аккаунта, ссылка для активации выслана на адрес электронной почты <b>%s</b>',

	'ulogin_read_response_error' => 'Невозможно получить данные.',
	'ulogin_read_response_error_text' => 'Для получения данных должен быть curl или file_get_contents.',

	'ulogin_login_error' => 'Получен неверный ID пользователя',

	'ulogin_profile_title'   => 'Социальные сети',
	'add_account'            => 'Социальные сети',
	'add_account_explain'    => 'Привяжите аккаунты соцсетей, кликнув по значку',
	'delete_account'         => 'Привязанные аккаунты',
	'delete_account_explain' => 'Удалите привязку к аккаунту, кликнув по значку',

	'admin_ulogin_title'          => 'uLogin',
	'admin_ulogin_title_explain'  => '
<p><a href="http://ulogin.ru" target="_blank">uLogin</a> — это инструмент, который позволяет пользователям получить единый доступ к различным Интернет-сервисам без необходимости повторной регистрации,
	а владельцам сайтов — получить дополнительный приток клиентов из социальных сетей и популярных порталов (Google, Яндекс, Mail.ru, ВКонтакте, Facebook и др.)</p>

<p>Чтобы создать свой виджет для входа на сайт достаточно зайти в Личный Кабинет (ЛК) на сайте <a href="http://ulogin.ru/lk.php" target="_blank">uLogin</a>,
	добавить свой сайт к списку "Мои сайты" и на вкладке "Виджеты" добавить новый виджет. Вы можете редактировать свой виджет самостоятельно.</p>

<p><b style="color: red;">Важно! </b>Для успешной работы плагина необходимо включить в обязательных полях профиля поле <b>Еmail</b> в Личном кабинете uLogin.</p><br/>

<p>Здесь Вы можете указать значение параметра "<b>uLogin ID</b>" Ваших виджетов.</p>',
	'admin_uloginid'                 => 'Значение поля uLogin ID',
	'admin_uloginid1'                => 'Значение поля uLogin ID №1',
	'admin_uloginid1_explain'        => 'Идентификатор виджета в окне входа и регистрации. Пустое поле - виджет по умолчанию.',
	'admin_uloginid2'                => 'Значение поля uLogin ID №2',
	'admin_uloginid2_explain'        => 'Идентификатор виджета в шапке сайта. Пустое поле - виджет по умолчанию.',
	'admin_uloginid_profile'         => 'Значение поля uLogin ID профиля пользователя',
	'admin_uloginid_profile_explain' => 'Идентификатор виджета в профиле пользователя. Пустое поле - виджет по умолчанию.',
	'ulogin_save'                    => 'Сохранить',
);