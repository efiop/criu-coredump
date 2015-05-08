from distutils.core import setup

setup(name = "criu-coredump",
      version = "0.0.1",
      description = "Generate core dumps from CRIU images",
      author = "Ruslan Kuprieiev",
      author_email = "kupruser@gmail.com",
      url = "https://github.com/efiop/criu-coredump",
      packages = ["criu_coredump"],
      scripts = ["criu-coredump"]
      )
