#include <iostream>
#include <fstream>
#include <sstream>  // for stringstream
#include <string>

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " filename\n";
        return 1;
    }

    std::ifstream file(argv[1]);
    if (!file) {
        std::cerr << "Unable to open file: " << argv[1] << "\n";
        return 1;
    }

    // Read whole file into a string
    std::stringstream buffer;
    buffer << file.rdbuf();
    std::string s = buffer.str();

    // Apply your transformation
    for (size_t i = 0; i < s.size(); i++) {
        char c = s[i] -= i;  // subtract i from the ASCII value of s[i]
        std::cout << c;
    }

    std::cout << std::endl;

    return 0;
}
