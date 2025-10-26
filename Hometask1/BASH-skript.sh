#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Использование: $0 <имя_файла>"
    exit 1
fi

filename="$1"

if [ -f "$filename" ]; then
    echo "Файл '$filename' существует."
    
    error_count=$(grep -i "error" "$filename" | wc -l)
    echo "Количество строк, содержащих слово 'error': $error_count"
    
else
    echo "Файл '$filename' не существует. Создаю новый файл..."
    
    cat > "$filename" << EOF
Тестовое сообщение
Сообщение с ошибкой error в тексте
Строка
ERROR
EOF
    
    echo "Файл '$filename' создан и заполнен тестовыми данными."
fi

echo "Отправка строк из файла на localhost:8080 через netcat..."

while IFS= read -r line; do
    echo "Отправка: $line"
    echo "$line" | nc -q 1 localhost 8080
    
done < "$filename"
