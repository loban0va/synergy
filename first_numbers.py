def sum_negative_numbers(numbers):
  if not numbers:
    return 0

  min_num = numbers[0]
  max_num = numbers[0]
  min_index = 0
  max_index = 0

  for i, num in enumerate(numbers):
    if num < min_num:
      min_num = num
      min_index = i
    if num > max_num:
      max_num = num
      max_index = i
  #print(min_num, max_num)
  start_index = min(min_index, max_index) + 1
  end_index = max(min_index, max_index)

  if start_index >= end_index:

  new_numbers = numbers[start_index:end_index]
  return sum(num for num in numbers if num < 0)

numbers = [1, 5, 10, -88, -30, 200, -5, -1, 9, -8, -3, -5]
result = sum_negative_numbers(numbers)
print(result)