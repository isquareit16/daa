#include <iostream>
#include <algorithm>
#include <vector>
#include <climits>

using namespace std;

const int ABS_MAX_CITIES = 10; 

int numberOfCities;             
vector<vector<int>> travelCost; 

int minTripCost[1 << ABS_MAX_CITIES][ABS_MAX_CITIES]; 

int findMinCost(int visitedMask, int currentCity) {
    if (minTripCost[visitedMask][currentCity] != -1) {
        return minTripCost[visitedMask][currentCity];
    }

    if (visitedMask == ((1 << numberOfCities) - 1)) {
        return travelCost[currentCity][0];
    }
    
    int overallMinimumCost = INT_MAX;
    
    for (int nextCity = 0; nextCity < numberOfCities; nextCity++) {
        
        if ((visitedMask & (1 << nextCity)) == 0) {
            
            int costForPath = travelCost[currentCity][nextCity] + 
                              findMinCost((visitedMask | (1 << nextCity)), nextCity); 
            
            overallMinimumCost = min(overallMinimumCost, costForPath);
        }
    }
    
    return minTripCost[visitedMask][currentCity] = overallMinimumCost;
}
 
int solveTravelingSalesperson() {
    return findMinCost(1, 0);   
}

int main() {
    cout << "TRAVELING SALESPERSON PROBLEM (TSP) SOLVER" << endl;
    cout << "==========================================" << endl;
    cout << "Enter the number of cities (N, max " << ABS_MAX_CITIES << "): ";
    if (!(cin >> numberOfCities)) {
        cerr << "Invalid input for number of cities." << endl;
        return 1;
    }

    if (numberOfCities <= 0 || numberOfCities > ABS_MAX_CITIES) {
        cerr << "Error: Number of cities must be between 1 and " << ABS_MAX_CITIES << "." << endl;
        return 1;
    }

    travelCost.resize(numberOfCities, vector<int>(numberOfCities));

    cout << "\nEnter the " << numberOfCities << "x" << numberOfCities << " travel cost matrix (C[i][j] from city i to j):" << endl;

    for(int i = 0; i < numberOfCities; ++i) {
        for(int j = 0; j < numberOfCities; ++j) {
            cout << "Cost from City " << i << " to City " << j << ": ";
            if (!(cin >> travelCost[i][j])) {
                 cerr << "Error reading cost. Aborting." << endl;
                 return 1;
            }
        }
    }
    
    for(int i = 0; i < (1 << numberOfCities); ++i) {
        for(int j = 0; j < numberOfCities; ++j) {
              minTripCost[i][j] = -1;
        }
    }

    int shortestRouteCost = solveTravelingSalesperson();
    
    cout << "\n==========================================" << endl;
    cout << "RESULTS" << endl;
    cout << "Starting City: 0" << endl;
    cout << "Total Cities: " << numberOfCities << endl;
    cout << "Minimum Traveling Salesperson Tour Cost: " << shortestRouteCost << endl;
    cout << "==========================================" << endl;
    
    return 0;
}



// OUTPUT --
// TRAVELING SALESPERSON PROBLEM (TSP) SOLVER
// ==========================================
// Enter the number of cities (N, max 10): 4

// Enter the 4x4 travel cost matrix (C[i][j] from city i to j):
// Cost from City 0 to City 0: 4
// Cost from City 0 to City 1: 2
// Cost from City 0 to City 2: 3
// Cost from City 0 to City 3: 4
// Cost from City 1 to City 0: 2
// Cost from City 1 to City 1: 5
// Cost from City 1 to City 2: 3
// Cost from City 1 to City 3: 5
// Cost from City 2 to City 0: 6
// Cost from City 2 to City 1: 8
// Cost from City 2 to City 2: 5
// Cost from City 2 to City 3: 4
// Cost from City 3 to City 0: 3
// Cost from City 3 to City 1: 6
// Cost from City 3 to City 2: 3
// Cost from City 3 to City 3: 6

// ==========================================
// RESULTS
// Starting City: 0
// Total Cities: 4
// Minimum Traveling Salesperson Tour Cost: 12
// ==========================================
