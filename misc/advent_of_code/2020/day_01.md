
[comment]: # (day_01.md)

# Advent of Code 2020

## Day 1 - Report Repair - 12/2/2020

### Part 1

After saving Christmas five years in a row, you've decided to take a vacation at a nice resort on a tropical island. Surely, Christmas will go on without you.

The tropical island has its own currency and is entirely cash-only. The gold coins used there have a little picture of a starfish; the locals just call them stars. None of the currency exchanges seem to have heard of them, but somehow, you'll need to find fifty of these coins by the time you arrive so you can pay the deposit on your room.

To save your vacation, you need to get all fifty stars by December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.

Specifically, they need you to find the two entries that sum to `2020` and then multiply those two numbers together.

For example, suppose your expense report contained the following:

|      |
|------|
| 1721 |
| 979  |
| 366  |
| 299  |
| 675  |
| 1456 |

In this list, the two entries that sum to `2020` are `1721` and `299`. Multiplying them together produces `1721 * 299 = 514579`, so the correct answer is `514579`.

Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?

To begin, [get your puzzle input](https://adventofcode.com/2020/day/1/input):

```
1688
1463
1461
1842
1441
1838
1583
1891
1876
1551
1506
2005
1989
1417
1784
1975
1428
1485
1597
1871
105
788
1971
1892
1854
1466
1584
1565
1400
1640
1780
1774
360
1421
1368
1771
1666
1707
1627
1449
1677
1504
1721
1994
1959
1862
1768
1986
1904
1382
1969
1852
1917
1966
1742
1371
1405
1995
1906
1694
1735
1422
1719
1978
1641
1761
1567
1974
1495
1973
1958
1599
1770
1600
1465
1865
1479
1687
1390
1802
2008
645
1435
1589
1949
1909
1526
1667
1831
1864
1713
1718
1232
1868
1884
1825
1999
1590
1759
1391
1757
323
1612
1637
1727
1783
1643
1442
1452
675
1812
1604
1518
1894
1933
1801
1914
912
1576
1961
1970
1446
1985
1988
1563
1826
1409
1503
1539
1832
1698
1990
1689
1532
765
1546
1384
1519
1615
1556
1754
1983
1394
1763
1823
1788
1407
1946
1751
1837
1680
1929
1814
1948
1919
1953
55
1731
1516
1895
1795
1890
1881
1799
1536
1396
1942
1798
1767
1745
1883
2004
1550
1916
1650
1749
1991
1789
1740
1490
1873
1003
1699
1669
1781
2000
1728
1877
1733
1588
1168
1828
1848
1963
1928
1920
1493
1968
1564
1572
```

### Solution

970816

```javascript
// Input: array of numbers
// Output: number that is the product of the two numbers in input that sum to 2020
// Rules/Implicit Knowledge
// Examples
//   console.log(productOf2020Sum([1721, 979, 366, 299, 675, 1456]) === 514579);
// Edge Cases
// Data Structure: array
// Algorithm
//   compare every pair of array elements
//     initialize an outerIndex from 0 to array length - 1
//     initilize an innerIndex from (outerIndex + 1) to array length - 1
//     if the two elements at outerIndex and innerIndex sum to 2020
//       return their product
// Code

let productOf2020Sum = function productOf2020Sum(numbers) {
  for (let outerIdx = 0; outerIdx < numbers.length; outerIdx += 1) {
    for (let innerIdx = outerIdx + 1; innerIdx < numbers.length; innerIdx += 1) {
      if (numbers[outerIdx] + numbers[innerIdx] === 2020) {
        return numbers[outerIdx] * numbers[innerIdx];
      }
    }
  }
};

const numbers = [1688, 1463, 1461, 1842, 1441, 1838, 1583, 1891, 1876, 1551,
  1506, 2005, 1989, 1417, 1784, 1975, 1428, 1485, 1597, 1871, 105, 788, 1971,
  1892, 1854, 1466, 1584, 1565, 1400, 1640, 1780, 1774, 360, 1421, 1368, 1771,
  1666, 1707, 1627, 1449, 1677, 1504, 1721, 1994, 1959, 1862, 1768, 1986, 1904,
  1382, 1969, 1852, 1917, 1966, 1742, 1371, 1405, 1995, 1906, 1694, 1735, 1422,
  1719, 1978, 1641, 1761, 1567, 1974, 1495, 1973, 1958, 1599, 1770, 1600, 1465,
  1865, 1479, 1687, 1390, 1802, 2008, 645, 1435, 1589, 1949, 1909, 1526, 1667,
  1831, 1864, 1713, 1718, 1232, 1868, 1884, 1825, 1999, 1590, 1759, 1391, 1757,
  323, 1612, 1637, 1727, 1783, 1643, 1442, 1452, 675, 1812, 1604, 1518, 1894,
  1933, 1801, 1914, 912, 1576, 1961, 1970, 1446, 1985, 1988, 1563, 1826, 1409,
  1503, 1539, 1832, 1698, 1990, 1689, 1532, 765, 1546, 1384, 1519, 1615, 1556,
  1754, 1983, 1394, 1763, 1823, 1788, 1407, 1946, 1751, 1837, 1680, 1929, 1814,
  1948, 1919, 1953, 55, 1731, 1516, 1895, 1795, 1890, 1881, 1799, 1536, 1396,
  1942, 1798, 1767, 1745, 1883, 2004, 1550, 1916, 1650, 1749, 1991, 1789, 1740,
  1490, 1873, 1003, 1699, 1669, 1781, 2000, 1728, 1877, 1733, 1588, 1168, 1828,
  1848, 1963, 1928, 1920, 1493, 1968, 1564, 1572];

console.log(productOf2020Sum([1721, 979, 366, 299, 675, 1456]) === 514579);
console.log(productOf2020Sum(numbers));   // 970816
```

---

### Part 2

The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.

Using the above example again, the three entries that sum to `2020` are `979`, `366`, and `675`. Multiplying them together produces the answer, `241861950`.

In your expense report, what is the product of the three entries that sum to 2020?

### Solution

96047280

```javascript
let productOf2020Sum = function productOf2020Sum(numbers) {
  for (let outerIdx = 0; outerIdx < numbers.length; outerIdx += 1) {
    for (let midIdx = outerIdx + 1; midIdx < numbers.length; midIdx += 1) {
      for (let innerIdx = midIdx + 1; innerIdx < numbers.length; innerIdx += 1) {
        if (numbers[outerIdx] + numbers[midIdx] + numbers[innerIdx] === 2020) {
          return numbers[outerIdx] * numbers[midIdx] * numbers[innerIdx];
        }
      }
    }
  }
};
```
