import numpy as np


# some sample array variables
a = np.arange(20).reshape(4,5)
b = np.array([10,15,20,30])
c = np.array([20,30,40,50])
e = np.random.random((4,5))
f = np.random.random((4,5))
g = np.ones(20).reshape(4,5)

# single dimensional variables
h = np.arange(10) ** 3


def array_detail(array):
    if a.any() == True: # there's definitely a better way to do this
        print(array.ndim)
        print(array.shape)
        print(array.size)
        print(array.dtype)
        print(array.itemsize)
        print(array.data)
    else:
        print('That\'s not an array! Try again using the function np.array()')


# function to allow you to call different operators on arrays
# array2 defaults to g, which is a matrix with ones
def array_math(array1, array2=g, operator='add'):
    try:
        if operator == 'add':
            print(array1 + array2)
        elif operator == 'subtract':
            print(array1 - array2)
        elif operator == 'multiply':
            print('NOTE: this is a matrix product rather than an element-wise product')
            print(array1.dot(array2))
        elif operator == 'divide':
            print(array1 / array2)
        elif operator == 'exponent':
            print(array1 ** array2)
        elif operator == 'cumsum':
            print(np.cumsum(array1))
        elif operator == 'square root':
            print(np.sqrt(array1))
        elif operator == 'exponent':
            print(np.exp(array1))
    except:
            print('Try again. Make sure your arrays have the same dimensions!')


# have to feed this a single-dimensional array
# index defaults to the 0th position
def array_manipulation(array1, operator, index=0):
    try:
        if operator == 'select':
            print(array1[{}].format(int(index))) # selects a number in the nth position
        elif operator == 'slice':
            print((array1[{}:{}]).format(int(index))) # slices from n to n-1
        elif operator == 'exponent loop':
            for i in array1:
                print(i ** 2.)
    except:
        print('Make sure you\'re using a one-dimensional array.')


array_detail(b)
array_math(b, c, 'multiply')
array_manipulation(b, 'exponent loop')
