// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Ratings{
    struct Restaurant {
        string name;
        string location;
        string theType;
        uint likes;
    }

    struct User {
        bool existed;
        string type1;
        string type2;
        string type3;
    }

    mapping(address => User) public users;
    address[] public usersList;

    address public administrator;

    Restaurant[] public restaurants;
    string[] restaurantNames = [
        "Chipotle Mexican Grill",
        "Happy Hot Hunan",
        "junzi Kitchen",
        "Chick-fil-A",
        "Shake Shack"
    ];
    string[] locations = ["Columbia", "Columbia", "Columbia", "Times Square", "Times Square"];
    string[] types = ["Mexican", "Chinese", "Chinese", "Hamburger", "Hamburger"];


    constructor(address _administrator) {
        administrator = _administrator;
        addUser(administrator);
        for (uint i = 0; i < restaurantNames.length; i++) {
            restaurants.push(Restaurant({
                name: restaurantNames[i],
                location: locations[i],
                theType: types[i],
                likes: 0
            }));
        }

    }

    function getRestaurant() public view returns (Restaurant[] memory) {
        return restaurants;
    }
    function getUser() public view returns (address[] memory) {
        require(msg.sender == administrator, "Only administrator can see the information.");
        return usersList;
    }

    function addUser(address _user) public {
        require(!users[_user].existed, "The user already existed.");
        users[_user].existed = true;
        usersList.push(_user);
    } 

    function like(uint index) external {
        require(users[msg.sender].existed,  "The user doesn't exist.");
        restaurants[index].likes += 1;

        string memory temp;
        string memory _type = restaurants[index].theType;
        if (keccak256(abi.encode(users[msg.sender].type1)) == keccak256(abi.encode(_type))) {
        } else if (keccak256(abi.encode(users[msg.sender].type2)) == keccak256(abi.encode(_type))) {
            temp = _type;
            users[msg.sender].type2 = users[msg.sender].type1;
            users[msg.sender].type1 = temp;
        } else if (keccak256(abi.encode(users[msg.sender].type3)) == keccak256(abi.encode(_type))) {
            temp = _type;
            users[msg.sender].type3 = users[msg.sender].type2;
            users[msg.sender].type2 = temp;
        } else {
            users[msg.sender].type3 = _type;
        }

        Restaurant memory temp2;
        while (index > 0 && restaurants[index-1].likes < restaurants[index].likes) {
            temp2 = restaurants[index];
            restaurants[index] = restaurants[index-1];
            restaurants[index-1] = temp2;
            index--;
        }
    }
    function topk(uint k) external view returns (string[] memory) {
        require(k <= restaurants.length);
        string[] memory topkList;
        for (uint i = 0; i < k; i++) {
            topkList[i] = restaurants[i].name;
        }
        return topkList;
    }
    function recommendation() external view returns (Restaurant memory recommend) {
        string memory _type = users[msg.sender].type1;
        for (uint i = 0; i < restaurants.length; i++) {
            if (keccak256(abi.encode(restaurants[i].theType)) == keccak256(abi.encode(_type))) {
                recommend = restaurants[i];
                return recommend;
            }
        }
        return restaurants[0];
    }
    function nearby(string memory _location) external view returns (Restaurant[] memory nearList) {
        for (uint i = 0; i < restaurants.length; i++) {
            if (keccak256(abi.encode(restaurants[i].location)) == keccak256(abi.encode(_location))) {
                nearList[i] = restaurants[i];
                return nearList;
            }
        }
    }
}