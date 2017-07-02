from django.shortcuts import render,render_to_response



def login(request):
    if request.user.is_authenticated():
        return render(request,"games.html")
    else:
        print(request.user)
        print(request.user.is_authenticated())
        return render(request,"login.html")


    pass
def logout(request):


    pass


    pass
def sign_up(request):

    pass