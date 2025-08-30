#!/usr/bin/env python3
"""
Django Debugging Example

This demonstrates how to debug Django applications using nvim-dap.
To use this with a real Django project:

1. Place this code in your Django views.py or models.py
2. Set breakpoints with <leader>db
3. Start your Django development server in debug mode
4. Use <leader>dc to attach the debugger
"""

# Example Django view for debugging
def user_profile_view(request, user_id):
    """Example Django view with debugging points"""
    from django.shortcuts import get_object_or_404
    from django.contrib.auth.models import User
    from django.http import JsonResponse
    
    # Set breakpoint here to inspect request object
    print(f"Processing request for user_id: {user_id}")
    
    try:
        # Set breakpoint here to debug user lookup
        user = get_object_or_404(User, id=user_id)
        
        # Set breakpoint here to inspect user data
        user_data = {
            'id': user.id,
            'username': user.username,
            'email': user.email,
            'is_active': user.is_active,
        }
        
        # Set breakpoint here to debug response creation
        return JsonResponse(user_data)
        
    except Exception as e:
        # Set breakpoint here to debug errors
        error_data = {
            'error': str(e),
            'user_id': user_id,
        }
        return JsonResponse(error_data, status=500)


# Example Django model method for debugging
class UserProfile:
    """Example Django model with debugging points"""
    
    def calculate_user_stats(self, user_id):
        """Calculate user statistics with debugging"""
        # Set breakpoint here to start debugging
        stats = {
            'total_posts': 0,
            'total_comments': 0,
            'last_login': None,
        }
        
        try:
            # Set breakpoint here to debug database queries
            # user = User.objects.get(id=user_id)
            # stats['total_posts'] = user.post_set.count()
            # stats['total_comments'] = user.comment_set.count()
            # stats['last_login'] = user.last_login
            
            # Simulated data for example
            stats['total_posts'] = 15
            stats['total_comments'] = 42
            
        except Exception as e:
            # Set breakpoint here to debug exceptions
            print(f"Error calculating stats: {e}")
            
        return stats


# Example Django management command debugging
def process_user_data():
    """Example management command with debugging"""
    users_processed = 0
    errors = []
    
    # Set breakpoint here to start debugging batch processing
    user_ids = [1, 2, 3, 4, 5]  # Example user IDs
    
    for user_id in user_ids:
        try:
            # Set breakpoint here to debug individual user processing
            profile = UserProfile()
            stats = profile.calculate_user_stats(user_id)
            
            # Set breakpoint here to inspect calculated stats
            print(f"User {user_id} stats: {stats}")
            users_processed += 1
            
        except Exception as e:
            # Set breakpoint here to debug processing errors
            error_msg = f"Failed to process user {user_id}: {e}"
            errors.append(error_msg)
            print(error_msg)
    
    # Set breakpoint here to review final results
    print(f"Processed {users_processed} users with {len(errors)} errors")
    return users_processed, errors


if __name__ == "__main__":
    # Test the debugging examples
    print("Django Debugging Examples")
    
    # Test user profile calculation
    profile = UserProfile()
    stats = profile.calculate_user_stats(1)
    print(f"User stats: {stats}")
    
    # Test batch processing
    processed, errors = process_user_data()
    print(f"Batch processing complete: {processed} users, {len(errors)} errors")