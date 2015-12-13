#include <iostream>
#include <string>
#include <fstream>

std::string between(std::string const &in,
                    std::string const &before, std::string const &after) {
  std::size_t beg = in.find(before);
  beg += before.size();
  std::size_t end = in.find(after, beg);
  return in.substr(beg, end-beg);
}

int main() {


    for (std::string line; std::getline(std::cin, line);) {

        std::string fileName = between(line, "[", "]");
        std::string data = between(line, "] ", "\n").append("\n");

        std::ofstream outfile;
        outfile.open(fileName.c_str(), std::ios_base::app);
        outfile << data;
    }
    return 0;
}
