a = 1          # integer
b = 0x1F       # integer
c = 1.0        # float
d = true       # boolean
e = :atom      # atom / symbol
f = "elixir"   # string
g = [1, 2, 3]  # list
h = {1, 2, 3}  # tuple

IO.puts(10 / 2) # 5.0, деление всегда возвращает float

# Атомы
# Это константы имена которых являются их значениями
# Булевы значения по факту атомы

h = :hello
IO.puts h #hello

IO.puts true == :true # true
IO.puts is_atom(false) # true
IO.puts is_boolean(:false) # true

# Строки
# Всегда в двойных ковычках

IO.puts "hello"
IO.puts "hello #{:world}" # интерполяция строк
IO.puts "hello\nworld"

IO.puts is_binary("hello") # строки представлены последовательность байт

IO.puts byte_size("hellö") # 6, т.к. ö - это 2 байта
IO.puts String.length("hellö") # 5 - вот так нужно проверять длину строки

# Анонимные функции
# Можно записать в строку
add = fn a, b -> a + b end
IO.puts add.(1,2) # Точка и скобки необходимы для вызова анонимной функции  

# проверка на арность (количество аргументов)
IO.puts is_function(add, 2) # true
IO.puts is_function(add, 1) # false

double = fn a -> add.(a, a) end # замыкания
IO.puts double.(2) # 4

x = 42
(fn -> x = 0 end).() # Присвоение значения перменной внутри функции не влияет на глобальную область видимости
IO.puts x # 42

# Связанные списки
# Могут содержать разные типы

IO.puts length [1, 2, true, 3] # 4
# Операторы списков никогда не меняют списки, всегда возвращают новый

list = [1, 2, 3]
IO.puts hd(list) # 1, Получение начального элемента списка, tl(list) - начиная со 2-го
IO.puts [104, 101, 108, 108, 111] # hello, Elixir преобразует список из ASCII чисел в символы
IO.puts 'hello' == "hello" # false, в одиночных список симоволов, в двойных - строка

# Кортежи
IO.inspect {:ok , "hello"}
IO.puts tuple_size {:ok , "hello"} # 2

# Кортежи записаны в память непрерывно, значит взять элемент по индексу - дешевая операция
IO.puts elem({:ok , "hello"}, 1) # "hello"
IO.inspect put_elem({:ok , "hello"}, 1, "world") # возвращает новый кортеж

# Списки или кортежи?
IO.inspect [0] ++ list # Дешевая операция
IO.inspect list ++ [0] # Дорогая (линейная сложность)

# Получение размера кортежа или элемента по индексу дешевая операция
# Апдейт элементов или добавление - дорогая операция, требуется создание нового кортежа
# Одно из использований кортежей в языке - возвращать доп. инфу из фукнции
# iex> File.read("path/to/existing/file")
# {:ok, "... contents ..."}
# iex> File.read("path/to/unknown/file")
# {:error, :enoent}

# size - операция за константное время
# length - операция за линейное время

# Ещё есть типы Port, Reference, и PID