def lambda_handler(event, context):
    print('event:', event)
    print('context:', context)

    # function response
    return {
        'code': 200,
        'status': 'success'
        'message': 'private lambda success exit message'
    }
