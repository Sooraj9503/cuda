{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": [],
      "gpuType": "T4",
      "authorship_tag": "ABX9TyNi9xN+A/V/wB29S4MqUNqO",
      "include_colab_link": true
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    },
    "accelerator": "GPU"
  },
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "view-in-github",
        "colab_type": "text"
      },
      "source": [
        "<a href=\"https://colab.research.google.com/github/Sooraj9503/cuda/blob/main/hello_world.cu\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": 2,
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "TdxMf8Jy-XLl",
        "outputId": "9ba54575-1f89-4494-ca37-79c94ac13358"
      },
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "Writing hello_world.cu\n"
          ]
        }
      ],
      "source": [
        "%%writefile hello_world.cu\n",
        "\n",
        "#include <iostream>\n",
        "\n",
        "__global__ void helloFromGPU() {\n",
        "    printf(\"Hello World from GPU!\\n\");\n",
        "}\n",
        "\n",
        "int main() {\n",
        "    helloFromGPU<<<1, 1>>>();\n",
        "    cudaDeviceSynchronize();\n",
        "    std::cout << \"Hello World from CPU!\\n\";\n",
        "    return 0;\n",
        "}\n"
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "!nvcc hello_world.cu -o hello_world\n"
      ],
      "metadata": {
        "id": "oeG6PSLv_Ffn"
      },
      "execution_count": 3,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "!./hello_world\n"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "a4xRfIZj_KZE",
        "outputId": "87b85d46-fe25-486a-948c-04d7f02936ef"
      },
      "execution_count": 4,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "Hello World from GPU!\n",
            "Hello World from CPU!\n"
          ]
        }
      ]
    }
  ]
}