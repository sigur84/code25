{
	"button": {
		"show": true,
		"text": "Форма безусловного партнера"
	},
	"fields": [
		{
			"type": "email",
			"name": "E-mail",
			"placeholder": "Ваш e-mail",
			"required": false,
			"sms": true
		},
		{
			"type": "tel",
			"mask": "Ваш номер",
			"name": "Номер телефона",
			"required": false,
			"sms": true
		},
		{
			"type": "text",
			"name": "Имя",
			"placeholder": "Ваше имя",
			"required": true,
			"sms": true
		}		
	],
	"form": {
		"template": "default",
		"title": "Форма безусловного партнера",
		"button": "Заказать"		
	},
	"alerts": {
		"yes": "Так",
		"no": "Нет",
		"process": "Отправка запроса ...",
		"success": "Ваш запрос успешно отправлен",
		"fails": {
			"required": "Пожалуйста, заполните все обязательные поля",
			"sent": "Предыдущее сообщение отправлено менее минуты назад"
		}
	},
	"captcha": {
		"show": false,
		"title": "Captcha",
		"error": "Captcha is wrong"
	},
	"license": {
		"key": "422033305436423430283020423433305122272633304820421830205426",
		"show": false
	},
	"mail": {
		"url": "Форма безусловного партнера",
	
		"smtp": false
	},
	"animationSpeed": 150,
	"sms": {
		"send": false,
		"captions": false,
		"cut": false
	}
}
