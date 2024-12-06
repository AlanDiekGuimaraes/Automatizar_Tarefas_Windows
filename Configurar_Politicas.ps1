# Altere a política para o escopo CurrentUser
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force

# Altere a política para o escopo LocalMachine
Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Unrestricted -Force

# Altere a política para o escopo Process
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force








    # Altere a política para o escopo CurrentUser
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted -Force

    # Altere a política para o escopo LocalMachine
    Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Restricted -Force

    # Altere a política para o escopo Process
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Restricted -Force
