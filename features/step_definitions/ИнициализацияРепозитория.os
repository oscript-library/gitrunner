﻿// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd

#Использовать asserts
#Использовать tempfiles

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;
	
	ВсеШаги = Новый Массив;
	
	ВсеШаги.Добавить("ЯСоздаюВременныйКаталогИСохраняюЕгоВКонтекст");
	ВсеШаги.Добавить("ЯИнициализируюРепозиторийВоВременномКаталоге");
	ВсеШаги.Добавить("ВоВременномКаталогеСуществуетРепозиторийGit");
	
	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт

КонецПроцедуры

//Я создаю временный каталог и сохраняю его в контекст
Процедура ЯСоздаюВременныйКаталогИСохраняюЕгоВКонтекст() Экспорт
	ВременныйКаталог = ВременныеФайлы.СоздатьКаталог();
	БДД.СохранитьВКонтекст("ВременныйКаталог", ВременныйКаталог);
КонецПроцедуры

//Я инициализирую репозиторий во временном каталоге
Процедура ЯИнициализируюРепозиторийВоВременномКаталоге() Экспорт
	ГитРепозиторий = БДД.ПолучитьИзКонтекста("ГитРепозиторий");
	ВременныйКаталог = БДД.ПолучитьИзКонтекста("ВременныйКаталог");
	ГитРепозиторий.УстановитьРабочийКаталог(ВременныйКаталог);
	ГитРепозиторий.Инициализировать();
КонецПроцедуры

//Во временном каталоге существует репозиторий git
Процедура ВоВременномКаталогеСуществуетРепозиторийGit() Экспорт
	ГитРепозиторий = БДД.ПолучитьИзКонтекста("ГитРепозиторий");
	ВременныйКаталог = БДД.ПолучитьИзКонтекста("ВременныйКаталог");
	
	КаталогГит = Новый Файл(ВременныйКаталог);
	Ожидаем.Что(КаталогГит.Существует(), "Временный каталог не существует").ЭтоИстина();

	Путь_СлужебныйКаталогГит = ОбъединитьПути(ВременныйКаталог, ".git");
	СлужебныйКаталогГит = Новый Файл(Путь_СлужебныйКаталогГит);
	Ожидаем.Что(СлужебныйКаталогГит.Существует(), "Во временном каталоге не обнаружен репозиторий git").ЭтоИстина();
КонецПроцедуры

