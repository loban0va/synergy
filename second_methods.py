class BaseClass:
    """
    Базовый класс с демонстрационными методами.
    """

    def __init__(self, name="Base"):
        self.name = name
        print(f"Конструктор базового класса {self.name}")

    def base_method(self):
        """
        Метод, специфичный для базового класса.
        """
        print(f"Метод base_method() в базовом классе {self.name}")

    def shared_method(self):
        """
        Метод, который может быть переопределен в производном классе.
        """
        print(f"Метод shared_method() в базовом классе {self.name}")

    def __str__(self):
        return f"Это экземпляр базового класса с именем {self.name}"


class DerivedClass(BaseClass):
    """
    Производный класс, наследующий от BaseClass.
    """

    def __init__(self, name="Derived", extra_data=None):
        super().__init__(name)
        self.extra_data = extra_data
        print(f"Конструктор производного класса {self.name}")

    def derived_method(self):
        """
        Метод, специфичный для производного класса.
        """
        print(f"Метод derived_method() в производном классе {self.name}")

    def shared_method(self):
        """
        Переопределенный метод shared_method() из базового класса.
        """
        print(f"Метод shared_method() в производном классе {self.name}")
        super().shared_method()

    def __str__(self):
        base_str = super().__str__()
        return f"{base_str} и некоторыми дополнительными данными: {self.extra_data}"


if __name__ == "__main__":
    base_object = BaseClass("Базовый объект")
    derived_object = DerivedClass("Производный объект", {"key": "value"})

    print("\nВызов методов базового класса:")
    base_object.base_method()
    base_object.shared_method()
    print(base_object)

    print("\nВызов методов производного класса:")
    derived_object.base_method()
    derived_object.derived_method()
    derived_object.shared_method()
    print(derived_object)