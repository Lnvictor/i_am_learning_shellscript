from collections import OrderedDict


my_dict = OrderedDict()


def populate(data: dict):
    my_dict.update(data)
    return True


if __name__ == "__main__":
    print(populate({}))