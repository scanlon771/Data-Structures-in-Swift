//Bubble Sort
//Implementation
public func bubbleSort<inputType: Comparable>(_ inputArray: inout [inputType]) {
    for endofArray in (1..<inputArray.count).reversed() {
        var swapped = false
        for currentIndex in 0..<endofArray {
            if inputArray[currentIndex] > inputArray[currentIndex + 1] {
                inputArray.swapAt(currentIndex, currentIndex + 1)
                swapped = true
            }
        }
        if !swapped {
            return
        }
    }
}

var testArray = [9, 2, 6, 4, 5]
print("Initial array: \(testArray)")
bubbleSort(&testArray)
print("Sorted array: \(testArray)")
//Output
"Initial array: [9, 2, 6, 4, 5]"
"Sorted array: [2, 4, 5, 6, 9]"

//Selection Sort
//Implementation
public func selectionSort<inputType: Comparable>(_ inputArray: inout [inputType]) {
    for currentIndex in 0..<(inputArray.count - 1) {
        var lowestValueIndex = currentIndex
        for nextIndex in (currentIndex + 1)..<(inputArray.count) {
            if inputArray[lowestValueIndex] > inputArray[nextIndex] {
                lowestValueIndex = nextIndex
            }
        }
        if lowestValueIndex != currentIndex {
            inputArray.swapAt(lowestValueIndex, currentIndex)
        }
    }
}

var testArray2 = [9, 2, 6, 4, 5, 10, 8]
print("Initial array: \(testArray2)")
selectionSort(&testArray2)
print("Sorted array: \(testArray2)")
//Output
"Initial array: [9, 2, 6, 4, 5, 10, 8]"
"Sorted array: [2, 4, 5, 6, 8, 9, 10] "

//Insertion Sort
//Implementation
public func insertionSort<inputType: Comparable>(_ inputArray: inout [inputType]) {
    for currentIndex in 1..<inputArray.count {
        for swap in (1...currentIndex).reversed() {
            if inputArray[swap] < inputArray[swap - 1] {
                inputArray.swapAt(swap, swap - 1)
            } else {
                break
            }
        }
    }
}

var testArray3 = [9, 2, 6, 4, 5, 10, 8, 12, 16, 11]
print("Initial array: \(testArray3)")
insertionSort(&testArray3)
print("Sorted array: \(testArray3)")
//Output
"Initial array: [9, 2, 6, 4, 5, 10, 8, 12, 16, 11]"
"Sorted array: [2, 4, 5, 6, 8, 9, 10, 11, 12, 16]"

//Merge Sort
//Implementation
public func mergeSort<inputType: Comparable>(_ inputArray: [inputType]) -> [inputType] {
    if inputArray.count < 2 {
        return inputArray
    }
    let center = (inputArray.count) / 2
    return merge(mergeSort([inputType](inputArray[0..<center])), rightList: mergeSort([inputType](inputArray[center..<inputArray.count])))
}

private func merge<inputType: Comparable>(_ leftList: [inputType], rightList: [inputType]) -> [inputType] {
    var leftIndex = 0
    var rightIndex = 0
    var tmpList = [inputType]()
    tmpList.reserveCapacity(leftList.count + rightList.count)
    while (leftIndex < leftList.count && rightIndex < rightList.count) {
        if leftList[leftIndex] < rightList[rightIndex] {
            tmpList.append(leftList[leftIndex])
            leftIndex += 1
        } else if leftList[leftIndex] > rightList[rightIndex] {
            tmpList.append(rightList[rightIndex])
            rightIndex += 1
        } else {
            tmpList.append(leftList[leftIndex])
            tmpList.append(rightList[rightIndex])
            leftIndex += 1
            rightIndex += 1
        }
    }
    tmpList += [inputType](leftList[leftIndex..<leftList.count])
    tmpList += [inputType](rightList[rightIndex..<rightList.count])
    return tmpList
}

var testArray4 = [9, 2, 6, 4, 5, 10, 8, 12, 16, 11]
print("Initial array: \(testArray4)")
print("Result array: \(mergeSort(testArray4))")
//Output
"Initial array: [9, 2, 6, 4, 5, 10, 8, 12, 16, 11]"
"Result array: [2, 4, 5, 6, 8, 9, 10, 11, 12, 16]"

//Quick Sort
//Implementation
func partition<inputType: Comparable>(_ inputArray: inout [inputType], lowIndex: Int, highIndex: Int) -> Int {
    let pivot = inputArray[highIndex]
    var i = lowIndex
    for j in lowIndex..<highIndex {
        if inputArray[j] <= pivot {
            inputArray.swapAt(i, j)
            i += 1
        }
    }
    inputArray.swapAt(i, highIndex)
    return i
}

func quickSort<inputType: Comparable>(_ inputArray: inout [inputType], lowIndex: Int, hiIndex: Int) {
    if lowIndex < hiIndex {
        let pivot = partition(&inputArray, lowIndex: lowIndex, highIndex: hiIndex)
        quickSort(&inputArray, lowIndex: lowIndex, hiIndex: pivot - 1)
        quickSort(&inputArray, lowIndex: pivot + 1, hiIndex: hiIndex)
    }
}

private func getMedian<inputType: Comparable>(_ inputArray: inout [inputType], lowIndex: Int, highIndex: Int) -> inputType {
    let center = lowIndex + (highIndex - lowIndex) / 2
    if inputArray[lowIndex] > inputArray[center] {
        inputArray.swapAt(lowIndex, center)
    }
    if inputArray[lowIndex] > inputArray[highIndex] {
        inputArray.swapAt(lowIndex, highIndex)
    }
    if inputArray[center] > inputArray[highIndex] {
        inputArray.swapAt(lowIndex, highIndex)
    }
    inputArray.swapAt(center, highIndex)
    return inputArray[highIndex]
}
