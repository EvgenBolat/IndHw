# Хавронич Евгений Алексеевич, БПИ226
---
## Вариант 32
### Условие:
Сформировать массив B из элементов массива A, которые меньше суммы элементов, расположенных на четных местах.
### Программы:
[Программы на ассемблере с комментариями размещены здесь](Files)
## Программа была написана на оценку 9.

### Требования на 9:
- Добавлено в программу использование макросов для реализации
ввода и вывода данных. Используется библиотека macrolib, из неё применяются print_int, read_int, print_str и newline.
- Обернул в макросы все уже ранее разработанные подпрограммы и оформил в виде библиотеки [MyLib](Files/MyLib.s).
- Все макросы поддерживают повторное использование с различными массивами и другими параметрами.

### Требования на 8:
- Разработанные подпрограммы поддерживают многократное использование с различными наборами исходных данных, включая возможность подключения различных исходных и результирующих массивов. Это достигается передачей в качестве параметра регистра, который хранит указатель на массив
- Реализовано автоматизированное тестирование за счет создания
дополнительной тестовой программы [TestProgram.asm](Files/TestProgram.asm) , осуществляющей прогон подпрограммы обработки массивов с различными тестовыми данными (вместо ввода данных). От пользователя требуется лишь запустить файл, и выходные данные будут выведены в консоль после выполнения тестов. Осуществлён прогон тестов, обеспечивающих покрытие различных ситуаций. Результаты выполнения тестовой программы представлены в таблице ниже.
<table>
    <tr>
        <th>№ теста</th>
        <th>Какую ситуацию проверяет</th>
        <th>Массив А</th>
        <th>Сумма элементов на чётных местах</th>
        <th>Массив B</th>
    </tr>
    <tr>
        <td>1</td>
        <td>Обычный массив</td>
        <td>2 -6 0 2343 -123</td>
        <td>-121</td>
        <td>-123</td>
    </tr>
    <tr>
        <td>2</td>
        <td>Массив из нулей</td>
        <td>0 0 0</td>
        <td>0</td>
        <td> Array is empty</td>
    </tr>
    <tr>
        <td>3</td>
        <td>Все элементы меньше суммы</td>
        <td>2 0 -6</td>
        <td>-8</td>
        <td>Array is empty</td>
    </tr>
    <tr>
        <td>4</td>
        <td>Введение 10 элементов</td>
        <td>234 0 -24 1000 34 -234 423 12 90 31</td>
        <td>757</td>
        <td>234 0 -24 34 -234 423 12 90 31</td>
    </tr>
    <tr>
        <td>5</td>
        <td>10 элементов и переполнение</td>
        <td>2147482647 0 -24 1500 3400 -234 423 12 90 31</td>
        <td>There's been an overflow!</td>
        <td>There's been an overflow!</td>
    </tr>
</table>

### Требования на 7:
- В программе использовались подпрограммы с передачей
аргументов через параметры, отображаемые на стек. 
    - В inputSize никакие параметры не передавались. 
    - В inputArray и SumOfEvenIndexes оба параметра сохраняются на стек. 
    - В ArrayFromElemLessSum все 4 параметра сохраняются на стек.
    - В printArray параметр сохраняется на стек.
    – Во всех подпрограммах на стеке сразу же сохранялся ra, а позже возвращался.
- Внутри подпрограмм используются локальные переменные, которые при компиляции отображауются на стек.
    - В inputSize сохраняется одна и единственная локальная переменная.
    - в inputArray локальных переменных нет, используются лишь параметры на стеке.
    - в SumOfEvenIndexes сохраняются все 3 локальные переменные. Остаток не требует сохранения, так как используется сразу после вычисления и более не нужен на всём шаге.
    - в ArrayFromElemLessSum сохряняется одна и единственная локальная переменная.
    - в printArray нет локальных переменных – используется сохранённые на стеке параметры.
- В местах вызова функции в файле [WithTheInputTest.asm](Files/WithTheInputTest.asm) , где пользователь сам вводит с консоли данные, добавлены комментарии, описывающие передачу фактических параметров и перенос возвращаемого результата. Также отмечены, какая переменная или результат какого выражения соответствует тому или иному фактическому параметру.

### Требования на 4-5:
- Приведено решение задачи на ассемблере.
- Ввод данных осуществляется с клавиатуры.
- Вывод данных осуществляется на дисплей.
## Общий алгоритм программы.
1. Вызов inputSize. В качестве аргумента получаем регистр, куда будет передан размер массива. В этом макросе происходит вызов ввода целого числа, и если число попадает в отрезок [1,10], то макрос успешно завершает свою работу и выполнение программы продолжается дальше. Если не попадает, то программа завершается и выводится сообщение о причине завершения программы.
2. Вызов inputArray. В него передаётся размер массива, который мы получили ранее, и указатель на массив, который будет заполняться. В макросе происходит вызов ввода целого числа столько раз, сколько передали в качестве размера массива.
3. Вызов printArray. Аргументы аналогичны тем, что передавались в inputArray. В макросе происходит вывод элементов массива в консоль через пробел.
4. Вызов SumOfEvenIndexes. Первые аргументы аналогичны передававшимся в последних двух описанных функциях, также передаётся регистр, в который будет записана сумма элементов массива, расположенных на чётных индексах. Учтено переполнение в левую и правую сторону: если это может случиться, то выполнение программы завершается с выводом в консоль текста о том, что произошло переполнение.
5. Вызов ArrayFromElemLessSum. Аргументы: сумма элементов на чётных индексах массива А, размер массива А, указатель на массив А, указатель на массив B, регистр, куда запишется размер заполненного массива B. В данном макросе происходит запись элементов массива А в массив B, которые меньше переданной в качестве первого аргумента суммы. Из макроса в последний параметр записывается размер заполненного массива.
