//
//  MATConstant.swift
//  Material
//
//  Created by Noirozr on 16/3/15.
//  Copyright © 2016年 Yongjia Liu. All rights reserved.
//

import UIKit

let DSData = ["Array", "Stack", "Queue", "Linked List", "Tree", "Graph", "Heap", "Hash"]
let DSTotal = 8
let titleArr = ["Data Structures Progress", "Algorithm Progress", "Total Progress"]
let sortData = ["Bubble Sort", "Quick Sort", "Insertion Sort", "Selection sort", "Heap Sort"]
let ALTotal = 5

let Best = [4, 2, 4, 16, 2]
let Average = [16, 2, 16, 16, 2]
let Worst = [16, 16, 16, 16, 2]
let Memory = [2, 1, 2, 2, 2]

struct MATConstant {
    static let NavigationBarHeight: CGFloat = 64
}

let arrayUrl = "http://visualgo.net/sorting"
let stackUrl = "http://visualgo.net/list"
let queueUrl = "http://visualgo.net/list"
let listUrl = "http://visualgo.net/list"
let treeUrl = "http://visualgo.net/bst"
let graphUrl = "http://visualgo.net/graphds"
let heapUrl = "http://visualgo.net/heap"
let hashUrl = "http://visualgo.net/hashtable"

//best n nlogn n n^2 nlogn
//average n^2 nlogn n^2 n^2 nlogn
//worst n^2 n^2 n^2 n^2 nlogn
//memory 1 logn 1 1 1


let bubbleSortData = [
    [3, 1, 5, 4, 2],
    [1, 3, 5, 4, 2],
    [1, 3, 4, 5, 2],
    [1, 3, 4, 2, 5],
    [1, 3, 2, 4, 5],
    [1, 2, 3, 4, 5]
                    ]

let quickSortData = [
    [3, 1, 5, 4, 2],
    [3, 1, 2, 4, 5],
    [2, 1, 3, 4, 5],
    [1, 2, 3, 4, 5]
]

let selectionSortData = [
    [3, 1, 5, 4, 2],
    [1, 3, 5, 4, 2],
    [1, 2, 5, 4, 3],
    [1, 2, 3, 4, 5]
                    ]

let insertionSortData = [
    [3, 1, 5, 4, 2],
    [1, 3, 5, 4, 2],
    [1, 3, 4, 5, 2],
    [1, 2, 3, 4, 5]
]

let heapSortData = [
    [3, 1, 5, 4, 2],
    [5, 1, 3, 4, 2],
    [5, 2, 3, 4, 1],
    [5, 4, 3, 2, 1],
    [1, 4, 3, 2, 5],
    [3, 4, 1, 2, 5],
    [4, 3, 1, 2, 5],
    [1, 3, 2, 4, 5],
    [3, 1, 2, 4, 5],
    [2, 1, 3, 4, 5],
    [1, 2, 3, 4, 5]
]

